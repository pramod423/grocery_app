import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class OnBoardScreen extends StatefulWidget {
  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  @override
  final _controller = PageController(
    initialPage: 0,
  );

  int _currentPage = 0;

  List<Widget> _pages = [
    Column(
      children: [
        Expanded(child: Image.asset('images/enteraddress.png')),
        Text(
          'Set Your Delivery Location',
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    ),
    Column(
      children: [
        Expanded(child: Image.asset('images/orderfood.png')),
        Text('Order Online from Your Favourite Store',
            style: TextStyle(fontWeight: FontWeight.bold))
      ],
    ),
    Column(
      children: [
        Expanded(child: Image.asset('images/deliverfood.png')),
        Text('Quick Deliver to your Doorstep',
            style: TextStyle(fontWeight: FontWeight.bold))
      ],
    )
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              children: _pages,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          DotsIndicator(
            dotsCount: _pages.length,
            position: _currentPage.toDouble(),
            decorator: DotsDecorator(
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                activeColor: Colors.orangeAccent),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
