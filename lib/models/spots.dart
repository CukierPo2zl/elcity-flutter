import 'package:elcity/models/user.dart';
import 'package:equatable/equatable.dart';

class Spot extends Equatable {
  final int id;
  final bool anonymous;
  final String content;
  final User user;

  const Spot({this.id, this.anonymous, this.content, this.user});

  @override
  List<Object> get props => [id, anonymous, content, user];

  @override
  String toString() => 'Spot { content: $content }';
}