import 'package:flutter/material.dart';

class UserModel {
  String? uid;
  String? email;
  String? userName;
  int? score = 0;

  UserModel({this.uid, this.email, this.userName,this.score});

  factory UserModel.fromMap(map){
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      userName: map['userName'],
      score: map['score'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid' : uid,
      'email': email,
      'userName': userName,
      'score': score,
    };
  }
}
