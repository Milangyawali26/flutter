import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? fullName;
  int? phoneNumber;
  String? address;
  String? gender;
  String? email;
  String? bloodGroup;
  DateTime? dateofbirth;



  UserModel({
    this.id,
    this.fullName,
    this.phoneNumber,
    this.address,
    this.gender,
    this.email,
    this.bloodGroup,
    this.dateofbirth,
  });

  toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'phone_number': phoneNumber,
      'address': address,
      'gender': gender,
      'email_id': email,
      'blood_group':bloodGroup,
      'Date of birth':dateofbirth,
    };
  }

  factory UserModel.fromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> document) {
    final userData = document.data();
    return UserModel(
      id: userData['id'],
      fullName: userData['full_name'],
      phoneNumber: userData['phone_number'],
      address: userData['address'],
      gender: userData['gender'],
      email: userData['email_id'],
      bloodGroup: userData['bloodGroup'],
    );
  }
}
