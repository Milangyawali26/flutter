import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_application_1/homepage.dart";
import "package:flutter_application_1/login.dart";
import "package:flutter_application_1/profile.dart";

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
@override

 void initState() {
    super.initState();
    // Add a delay using Timer for 3 seconds
    Timer(Duration(seconds: 3), () {
      // After the delay, navigate to the main page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => homepage(),
        ),
      );
    });
  }
  

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Center(
        child: CircularProgressIndicator(),
      )
    );
  }
}