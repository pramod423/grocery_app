import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/screens/home_screen.dart';
import 'package:grocery_app/services/user_services.dart';

class AuthProvider with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String smsOtp;
  String verificationId;
  String error = '';
  UserServices _userServices = UserServices();

  Future<void> verifyPhone(BuildContext context, String number) async {
    final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential credential) async {
      await _auth.signInWithCredential(credential);
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException e) {
      print(e.code);
    };

    final PhoneCodeSent smsOtpSend = (String verdID, int resendToken) async {
      this.verificationId = verdID;

      //open dialog to enter receiver msg
      smsOtpDialog(context, number);
    };
    try {
      _auth.verifyPhoneNumber(
          phoneNumber: number,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: smsOtpSend,
          codeAutoRetrievalTimeout: (String veriId) {
            this.verificationId = veriId;
          });
    } catch (e) {
      print(e);
    }
  }

  Future<bool> smsOtpDialog(BuildContext context, String number) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              children: [
                Text(
                  'Verification Code',
                ),
                SizedBox(height: 6),
                Text(
                  'Enter 6 digit OTP received as SMS',
                  style: TextStyle(fontSize: 12.0),
                ),
              ],
            ),
            content: Container(
              alignment: Alignment.center,
              height: 85,
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 6,
                onChanged: (value) {
                  this.smsOtp = value;
                },
              ),
            ),
            actions: [
              FlatButton(
                  onPressed: () async {
                    try {
                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                              verificationId: verificationId, smsCode: smsOtp);
                      final User user =
                          (await _auth.signInWithCredential(credential)).user;
                      //create user data in firestore after user successfully register
                      _createUser(id: user.uid, number: user.phoneNumber);
                      //navigate to home page after login
                      if (user != null) {
                        Navigator.of(context).pop();

                        //dont want tocome back to welcome screenafter logged in
                        Navigator.pushReplacementNamed(context, HomeScreen.id);
                      } else {
                        print('login failed');
                      }
                    } catch (e) {
                      this.error = 'Invalid OTP';
                      print(e.toString());
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('DONE'))
            ],
          );
        });
  }

  void _createUser({String id, String number}) {
    _userServices.createUserData({
      'id': id,
      'number': number,
    });
  }
}
