import 'package:flutter/material.dart';

class UserModel {
  String? uid;
  String? email;
  String? userName;

  UserModel({this.uid, this.email, this.userName});

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      userName: map['userName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'userName': userName,
    };
  }
}
