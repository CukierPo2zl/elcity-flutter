import 'package:equatable/equatable.dart';

abstract class MySpotEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Fetch extends MySpotEvent {}
class Delete extends MySpotEvent{}