// import 'dart:js';

import 'dart:js';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Signup.dart';
import 'package:flutter_application_1/Splash.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/homepage.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/profile.dart';

void main() {
  // function is used to ensure
  //  that Flutter has been properly initialized
  // before executing any code that depends on it.
  WidgetsFlutterBinding.ensureInitialized();
  initializeFirebase();

  runApp(MaterialApp(
    title: 'flutter App',
    theme: ThemeData(
      colorSchemeSeed: Color.fromARGB(255, 92, 9, 9),
    ),
    routes: {
      '/': (context) => Splash(),
      '/login': (context) => Login(),
      '/Signup': (context) => SignUp(),
      '/homepage':(context)=>homepage(),
      '/profile':(context)=>profile(),
    },
    initialRoute: '/',
    debugShowCheckedModeBanner: false,
  ));
}

///this funtion is to initialize FireBase
void initializeFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}
