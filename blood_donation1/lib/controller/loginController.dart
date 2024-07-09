
import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/firebase_auth_services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginController extends GetxController{
  final formKey = GlobalKey<FormState>();
  final emailController =TextEditingController();
  final passwordController=TextEditingController();
  var passwordVisible= false.obs;

  var isChecked=false.obs;

  handleLogin(BuildContext context)async{
    if(isChecked.value){
      final firebaseAuthService =FirebaseAuthService();
      final email = emailController.text;
      final password= passwordController.text;
      final User? user =await firebaseAuthService.loginWithEmailAndPassword(email,password);
      if(user!=null){
        final SharedPreferences prefs=await SharedPreferences.getInstance();
        await prefs.setString('id',user.uid);
        print("login Sucess");
        Navigator.of(context).pushReplacementNamed('/homepage');
        
      }
      else{
        print("please check the term");
      }

    }
  }

}