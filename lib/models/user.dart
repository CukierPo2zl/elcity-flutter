import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class User {
  final String email;
  final String username;
  final String age;
  final IconData image;
  User(this.email, this.username, this.age, this.image);



  @override
  String toString() => '$username';
}