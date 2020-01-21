import 'package:elcity/models/user.dart';
import 'package:equatable/equatable.dart';

class Spot extends Equatable {
  final bool anonymous;
  final String content;
  final User user;

  const Spot({this.anonymous, this.content, this.user});

  @override
  List<Object> get props => [ anonymous, content, user];

  @override
  String toString() => 'Spot { content: $content }';
}