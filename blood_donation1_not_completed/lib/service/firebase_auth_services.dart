

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService{

  FirebaseAuth _auth = FirebaseAuth.instance; 

  //  sign up
  Future<User?> signUpWithEmailAndPassword(String email,String password) async{
    try{
       
      UserCredential credential =await _auth.createUserWithEmailAndPassword(email:email,password:password);   
      return credential.user;
    }
    catch(e)
    {
      print("some error occured");
    }
    return null;
  } 
  //  log in
  Future<User?> loginWithEmailAndPassword(String email,String password) async{
    try{
       
      UserCredential credential =await _auth.signInWithEmailAndPassword(email: email, password: password);   
      return credential.user;
    }
    catch(e)
    {
      print("some error occured");
    }
    return null;
  } 

  // sign  out
   void signOutUser() async {
    await _auth.signOut();
  }

  User? getCurrentUser() {
    try {
      return _auth.currentUser;
    } catch (e) {
      print('Something Went Wrong');
    }
    return null;
  }
}