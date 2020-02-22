import 'package:equatable/equatable.dart';

abstract class SpotEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Fetch extends SpotEvent {}
class ForceRefresh extends SpotEvent{}