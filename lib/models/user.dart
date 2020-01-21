import 'package:equatable/equatable.dart';

class User {
  final String email;
  final String username;
  final String age;

  User(this.email, this.username, this.age);



  @override
  String toString() => '$username';
}