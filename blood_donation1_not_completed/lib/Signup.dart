// ignore_for_file: dead_code

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/service/firebase_auth_services.dart';
import 'package:flutter_application_1/service/firebase_database_service.dart';
import 'package:country_code_picker/country_code_picker.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _emailAddressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailRegexPattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();

  String gender = 'Male';
  String bloodGroup = 'O+';

  final _dateController = TextEditingController();
  
  @override
  // Future<void> _selectDate() async {
  //   DateTime? _picked = await showDatePicker(
  //       context: context,
  //       initialDate: DateTime.now(),
  //       firstDate: DateTime(1900),
  //       lastDate: DateTime(2100));
  //   if (_picked != null) {
  //     setState(() {
  //       _dateController.text = _picked.toString().split(" ")[0];
  //     });
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('Register'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _fullNameController,
                        keyboardType: TextInputType.name,
                        maxLength: 30,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter full name',
                        ),
                        validator: (fullNameValue) {
                          if (fullNameValue == null ||
                              fullNameValue.trim().isEmpty) {
                            return 'Please Enter Full Name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _emailAddressController,
                        maxLength: 30,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email address',
                        ),
                        validator: (emailValue) {
                          if (emailValue == null || emailValue.trim().isEmpty) {
                            return 'Please enter your email address';
                          }
                          final regex = RegExp(_emailRegexPattern);
                          if (!regex.hasMatch(emailValue)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        maxLength: 20,
                        obscureText: true, //making non visible password
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter your password',
                        ),
                        validator: (passwordValue) {
                          if (passwordValue == null ||
                              passwordValue.trim().isEmpty) {
                            return 'Please Enter password';
                          }
                          return null;
                        },
                      ),
                      Wrap(
                        children: [
                          Container(
                            child:CountryCodePicker(
                            initialSelection: 'NEP',
                            showCountryOnly: false,
                            showOnlyCountryWhenClosed: false,
                            favorite: ['+977', 'NEP'],
                            enabled: true,
                            hideMainText: false,
                            showFlagMain: true,
                            showFlag: true,
                            hideSearch: false,
                            showFlagDialog: true,
                            alignLeft: true,
                          )
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            child: TextFormField(
                              maxLength: 10,
                              controller: _phoneNumberController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Mobile Number',
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              validator: (phoneNumberValue) {
                                if (phoneNumberValue == null ||
                                    phoneNumberValue.trim().isEmpty) {
                                  return 'Please enter your phone number';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                        
                      ),
                      TextFormField(
                        controller: _addressController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Enter your Address")),
                      ),
                      SizedBox(height: 20),
                      Text('Select your Gender '),
                      Row(
                        children: [
                          Radio(
                            value: "male",
                            groupValue: gender,
                            onChanged: ((newValue) {
                              setState(() {
                                if (newValue != null) {
                                  gender = newValue;
                                }
                              });
                            }),
                          ),
                          Text("male"),
                          SizedBox(
                            width: 30,
                          ),
                          Radio(
                            value: 'female',
                            groupValue: gender,
                            onChanged: ((newValue) {
                              setState(() {
                                if (newValue != null) {
                                  gender = newValue;
                                }
                              });
                            }),
                          ),
                          Text('female'),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Select your blood Group'),



                      

            //           DropdownButtonFormField(
            //   value: _selectedItem,
            //   items: _items.map((String value) {
            //     return DropdownMenuItem<String>(
            //       value: value,
            //       child: Text(value),
            //     );
            //   }).toList(),
            //   onChanged: (String newValue) {
            //     setState(() {
            //       _selectedItem = newValue;
            //     });
            //   },
            //   decoration: InputDecoration(
            //     labelText: 'Select Item',
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            // SizedBox(height: 20.0),





                      Column(
                        children: [
                          Row(children: [
                            Radio(
                              value: 'O+',
                              groupValue: bloodGroup,
                              onChanged: ((newValue) {
                                setState(() {
                                  if (newValue != null) {
                                    bloodGroup = newValue;
                                  }
                                });
                              }),
                            ),
                            Text(
                              "O+",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ]),
                          Row(children: [
                            Radio(
                              value: 'O-',
                              groupValue: bloodGroup,
                              onChanged: ((newValue) {
                                setState(() {
                                  if (newValue != null) {
                                    bloodGroup = newValue;
                                  }
                                });
                              }),
                            ),
                            Text(
                              "O-",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ]),
                          Row(children: [
                            Radio(
                              value: 'A-',
                              groupValue: bloodGroup,
                              onChanged: ((newValue) {
                                setState(() {
                                  if (newValue != null) {
                                    bloodGroup = newValue;
                                  }
                                });
                              }),
                            ),
                            Text(
                              "A-",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ]),
                          Row(children: [
                            Radio(
                              value: 'A+',
                              groupValue: bloodGroup,
                              onChanged: ((newValue) {
                                setState(() {
                                  if (newValue != null) {
                                    bloodGroup = newValue;
                                  }
                                });
                              }),
                            ),
                            Text(
                              "A+",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ]),
                          Row(children: [
                            Radio(
                              value: 'B+',
                              groupValue: bloodGroup,
                              onChanged: ((newValue) {
                                setState(() {
                                  if (newValue != null) {
                                    bloodGroup = newValue;
                                  }
                                });
                              }),
                            ),
                            Text(
                              "B+",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ]),
                          Row(children: [
                            Radio(
                              value: 'B-',
                              groupValue: bloodGroup,
                              onChanged: ((newValue) {
                                setState(() {
                                  if (newValue != null) {
                                    bloodGroup = newValue;
                                  }
                                });
                              }),
                            ),
                            Text(
                              "B-",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ]),
                          Row(children: [
                            Radio(
                              value: 'AB+',
                              groupValue: bloodGroup,
                              onChanged: ((newValue) {
                                setState(() {
                                  if (newValue != null) {
                                    bloodGroup = newValue;
                                  }
                                });
                              }),
                            ),
                            Text(
                              "AB+",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ]),
                          Row(children: [
                            Radio(
                              value: 'AB-',
                              groupValue: bloodGroup,
                              onChanged: ((newValue) {
                                setState(() {
                                  if (newValue != null) {
                                    bloodGroup = newValue;
                                  }
                                });
                              }),
                            ),
                            Text(
                              "AB-",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ]),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // TextField(
                      //   readOnly: true,
                      //   controller: _dateController,
                      //   decoration: InputDecoration(
                      //       labelText: "Date of birth",
                      //       filled: true,
                      //       prefixIcon: Icon(Icons.calendar_today),
                      //       enabledBorder: OutlineInputBorder(
                      //           borderSide: BorderSide(color: Colors.blue))),
                      //   onTap: () {
                      //     _selectDate();
                      //   },
                      // ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formkey.currentState != null) {
                            if (_formkey.currentState!.validate()) {
                              final email = _emailAddressController.text;
                              final password = _passwordController.text;

                              final firebaseAuthService = FirebaseAuthService();
                              User? user = await firebaseAuthService
                                  .signUpWithEmailAndPassword(email, password);
                              if (user != null) {
                                final userModel = UserModel(
                                    id: user.uid,
                                    fullName: _fullNameController.text,
                                    phoneNumber:
                                        int.parse(_phoneNumberController.text),
                                    address: _addressController.text,
                                    gender: gender,
                                    bloodGroup: bloodGroup,
                                    email: _emailAddressController.text,
                                    dateofbirth:
                                        DateTime.parse(_dateController.text));
                                FirebaseDatabaseService()
                                    .createUser(userModel: userModel);
                                _formkey.currentState!.reset();
                                Navigator.of(context)
                                    .pushReplacementNamed('/login');
                              } else {
                                print('Register Failure');
                              }
                            }
                          }
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      )
                    ],
                  )),
            ),
          ),
        ));
  }
}
