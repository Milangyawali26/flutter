 import 'package:flutter/material.dart';
import 'package:todolist/screens/authform.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.lightBlue,
        title: const Text('Authentication'),
        centerTitle: true,

      ),
      body: const AuthForm(),

    );
  }
}
