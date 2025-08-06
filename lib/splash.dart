import 'dart:async';

import 'package:flutter/material.dart';
import 'package:litz/Homepage/home.dart';
import 'package:litz/Login/signup.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class splash extends StatefulWidget {
  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 2),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Signup()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.deepOrange),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    "LITZ TECH",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "EMPOWERING BUSINESS GLOBALLY",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 50),
                  Center(child: Image.asset('assets/logo.png', height: 200)),
                ],
              ),
            ),

            SizedBox(height: 300),

            // LoadingAnimationWidget.dotsTriangle(color: Colors.white54, size: 50),
            LoadingAnimationWidget.fourRotatingDots(
              color: Colors.white,
              size: 100,
            ),
          ],
        ),
      ),
    );
  }
}
