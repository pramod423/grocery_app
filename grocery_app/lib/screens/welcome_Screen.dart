import 'package:flutter/material.dart';
import 'package:grocery_app/provider/auth_provider.dart';
import 'package:grocery_app/provider/location_provider.dart';
import 'package:grocery_app/screens/map_screen.dart';
import 'package:grocery_app/screens/onboard_screen.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  static const String id = 'welcome-screen';
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    bool _validPhoneNumber = false;
    var _phoneNumberController = TextEditingController();
    void showBottomSheet(context) {
      showModalBottomSheet(
          context: context,
          builder: (context) =>
              StatefulBuilder(builder: (context, StateSetter mystate) {
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Enter your phone number to login',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          TextField(
                            controller: _phoneNumberController,
                            decoration: InputDecoration(
                                prefixText: '+1',
                                labelText: '10 digit Mobile Number'),
                            autofocus: true,
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            onChanged: (value) {
                              if (value.length == 10) {
                                mystate(() {
                                  _validPhoneNumber = true;
                                });
                              } else {
                                mystate(() {
                                  _validPhoneNumber = false;
                                });
                              }
                            },
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: AbsorbPointer(
                                  absorbing: _validPhoneNumber ? false : true,
                                  child: FlatButton(
                                      color: _validPhoneNumber
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey,
                                      onPressed: () {
                                        String number =
                                            '+1${_phoneNumberController.text}';
                                        auth.verifyPhone(context, number);
                                      },
                                      child: Text(
                                        _validPhoneNumber
                                            ? 'CONTINUE'
                                            : 'ENTER PHONE NUMBER',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }));
    }

    final locationData = Provider.of<LocationProvider>(context, listen: false);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Positioned(
                top: 10,
                left: 250,
                child: FlatButton(
                    onPressed: () {},
                    child: Text(
                      'SKIP',
                      style: TextStyle(color: Colors.deepOrangeAccent),
                    ))),
            Column(
              children: [
                Expanded(child: OnBoardScreen()),
                Text('Ready to order from your nearest shop?'),
                SizedBox(
                  height: 20,
                ),
                FlatButton(
                  color: Colors.deepOrangeAccent,
                  child: Text('Set Delivary Location'),
                  onPressed: () async {
                    await locationData.getCurrentPosition();
                    if (locationData.permissionAllowed == true) {
                      Navigator.pushReplacementNamed(context, MapScreen.id);
                    } else {
                      print('permission not allowed');
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                FlatButton(
                    onPressed: () {
                      showBottomSheet(context);
                    },
                    child: RichText(
                        text: TextSpan(
                            text: 'Already a Customer ?',
                            style: TextStyle(color: Colors.black),
                            children: [
                          TextSpan(
                              text: ' Login',
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ])))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
