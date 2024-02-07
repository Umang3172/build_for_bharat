import 'package:animated_checkmark/animated_checkmark.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:animated_checkmark/animated_checkmark.dart';

class PurchasePopup extends StatefulWidget {
  @override
  _PurchasePopupState createState() => _PurchasePopupState();
}

class _PurchasePopupState extends State<PurchasePopup>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
        ),
        Center(
          child: Material(
            elevation: 8.0,
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              padding: EdgeInsets.all(16.0),
              width: 250.0,
              height: 200.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _animation.value,
                        child: AnimatedCheckmark(
                          active: true,
                          weight: 2,
                          size: const Size.square(50),
                          color: Colors.blue,
                          style: CheckmarkStyle.round,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Thanks for purchasing!',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
