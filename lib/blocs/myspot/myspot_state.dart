import 'package:elcity/models/spots.dart';
import 'package:equatable/equatable.dart';

abstract class MySpotState extends Equatable{
  const MySpotState();

  @override
  List<Object> get props => [];
}
class MySpotUninitialized extends MySpotState {}

class MySpotError extends MySpotState {}

class MySpotLoaded extends MySpotState {
   final List<Spot> spots;
  final int count;

  const MySpotLoaded({
    this.spots,
    this.count,
  });

    @override
  List<Object> get props => [spots, count];

  @override
  String toString() =>
      'MySpotLoaded { spots: ${spots.length}}';

}