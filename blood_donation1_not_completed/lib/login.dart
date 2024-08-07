// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Signup.dart';
import 'package:flutter_application_1/controller/loginController.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('Login'),
          centerTitle: true,
        ),
        body: Form(
            key: loginController.formKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                TextField(
                  controller: loginController.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Username  or emailAddress',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                SizedBox(height: 20.0),
                Obx(() {
                  return TextField(
                    controller: loginController.passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: loginController.passwordVisible.value,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                          icon: Icon(
                            loginController.passwordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            loginController.passwordVisible.value =
                                !loginController.passwordVisible.value;
                          }),
                    ),
                  );
                }),
                SizedBox(height: 20.0),
                Wrap(
                  children: [
                    ElevatedButton(
                      child: Text('Login'),
                      onPressed: () {
                        // Add login authentication logic here
                      },
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      child: Text('Reset'),
                      onPressed: () {
                        loginController.emailController.clear();
                        loginController.passwordController.clear();
                      },
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      child: Text('Sign Up'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            )));
  }
}
