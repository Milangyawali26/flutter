import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/model/user_model.dart';


class FirebaseDatabaseService {
  final usersList = [];
  final _firestoreDb = FirebaseFirestore.instance;

  ///This function is to get single user from firebase
  Future getSingleUser() async {
    try {
      final CollectionReference _usersCollectionReference =
          await _firestoreDb.collection('users');
      var userDetails = await _usersCollectionReference.doc('user2').get();
      if (userDetails.exists) {
        print('User Details ${userDetails.data()}');
      } else {
        print('User Not Found');
      }
    } catch (e) {
      print('Something went wrong');
    }
  }

  ///This function is to get all users in a collection
  Future getUsersInACollection() async {
    try {
      final CollectionReference _usersCollectionReference =
          await _firestoreDb.collection('users');
      await _usersCollectionReference.get().then((querySnapShot) {
        for (var doc in querySnapShot.docs) {
          usersList.add(doc.data());
        }
      });
      return usersList;
    } catch (e) {
      print('Something Went Wrong $e');
    }
  }

  ///This function is used to create user in cloud firestore
  void createUser({required UserModel userModel}) async {
    try {
      final CollectionReference _usersCollectionReference =
          await _firestoreDb.collection('users');
      await _usersCollectionReference.add(userModel.toJson()).whenComplete(() {
        print('User Creation Success');
      });
    } catch (e) {
      print('Something went wrong $e');
    }
  }

  ///This function is used to get user details according to id
  Future<UserModel?> getUserDetailsFromUId({required String uId}) async {
    print('Request UID $uId');
    try {
      final CollectionReference _usersCollectionReference =
          await _firestoreDb.collection('users');
      final documentSnapshot =
          await _usersCollectionReference.where('id', isEqualTo: uId).get();
      if (documentSnapshot.docs.isNotEmpty) {
        final userModel = documentSnapshot.docs
            .map((doc) => UserModel.fromJson(
                doc as QueryDocumentSnapshot<Map<String, dynamic>>))
            .first;
        return userModel;
      } else {
        print('Document not found');
      }
    } catch (e) {
      print('Something went wrong $e');
    }
    return null;
  }

  Future<List<UserModel>> getUsersFromDatabase() async {
    try {
      final CollectionReference _usersCollectionReference =
          await _firestoreDb.collection('users');
      final snapShot = await _usersCollectionReference.get();

      if (snapShot.docs.isNotEmpty) {
        return snapShot.docs
            .map((doc) => UserModel.fromJson(
                doc as QueryDocumentSnapshot<Map<String, dynamic>>))
            .toList();
      } else {
        throw Exception('User not found');
      }
    } catch (e) {
      print('Something went wrong $e');
    }
    return [];
  }

  ///Function to update user using uid
  Future<UserModel?> updateUserUsingUID(
      {required String uId, required UserModel userModel}) async {
    try {
      final CollectionReference _usersCollectionReference =
          await _firestoreDb.collection('users');
      final documentSnapshot =
          await _usersCollectionReference.where('id', isEqualTo: uId).get();
      if (documentSnapshot.docs.isNotEmpty) {
        final documentId = documentSnapshot.docs.first.id;
        await _usersCollectionReference
            .doc(documentId)
            .update(userModel.toJson());
      } else {
        return null;
      }
    } catch (e) {
      print('Something went wrong $e');
    }
    return null;
  }

  ///Function to delete a user using UID
  Future<List<UserModel>> deleteUserUsingUID({required String uId}) async {
    try {
      final CollectionReference _usersCollectionReference =
          await _firestoreDb.collection('users');
      final documentSnapshot =
          await _usersCollectionReference.where('id', isEqualTo: uId).get();

      if (documentSnapshot.docs.isNotEmpty) {
        final documentId = documentSnapshot.docs.first.id;

        await _usersCollectionReference.doc(documentId).delete();
        final usersSnapshot = await _usersCollectionReference.get();
        return usersSnapshot.docs
            .map((doc) => UserModel.fromJson(
                doc as QueryDocumentSnapshot<Map<String, dynamic>>))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Something went wrong!');
    }
    return [];
  }
}
