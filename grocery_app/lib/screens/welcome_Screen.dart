import 'package:flutter/material.dart';
import 'package:grocery_app/screens/onboard_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {},
                ),
                SizedBox(
                  height: 20,
                ),
                FlatButton(
                    onPressed: () {},
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
