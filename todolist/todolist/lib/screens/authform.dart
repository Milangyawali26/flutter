import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _email = '';
  var _password = '';
  var _username = '';
  bool _islogin = true;

  startauthentication() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus(); // this is to close the keyboard

    if (isValid) {
      _formKey.currentState!.save();
      submitform(_email, _password, _username);
    }
  }

  submitform(String email, String password, String username) async {
    final auth = FirebaseAuth.instance;
    UserCredential authResult;

    try {
      if (_islogin) {
        authResult = await auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String uid = authResult.user!.uid;
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'username': username,
          'email': email,
        });
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //email
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty || !value.contains("@")) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value!;
                      },
                      keyboardType: TextInputType.emailAddress,
                      key: ValueKey('email'),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    
                    // username
                    if (!_islogin)
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value.length < 4) {
                            return 'Please enter at least 4 characters';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _username = value!;
                        },
                        keyboardType: TextInputType.text,
                        key: ValueKey('username'),
                        decoration: InputDecoration(
                          labelText: 'Username',
                          hintText: 'Enter your username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),

                    //password
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 7) {
                          return 'Please enter at least 7 characters';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value!;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      key: ValueKey('password'),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 60,
                      width: 500,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            textStyle: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            )),
                      onPressed:(){
                          startauthentication();
                      },
                           // Pass the function reference
                        child: Text(_islogin ? 'Login' : 'Sign Up'),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _islogin = !_islogin;
                        });
                      },
                      child: Text(_islogin
                          ? 'Create new account'
                          : 'I already have an account'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
