import 'package:elcity/models/spots.dart';
import 'package:equatable/equatable.dart';



abstract class SpotState extends Equatable {
  const SpotState();

  @override
  List<Object> get props => [];
}

class SpotUninitialized extends SpotState {}

class SpotError extends SpotState {}

class SpotLoaded extends SpotState {
  final List<Spot> spots;
  final bool hasReachedMax;

  const SpotLoaded({
    this.spots,
    this.hasReachedMax,
  });

  SpotLoaded copyWith({
    List<Spot> spots,
    bool hasReachedMax,
  }) {
    return SpotLoaded(
      spots: spots ?? this.spots,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [spots, hasReachedMax];

  @override
  String toString() =>
      'PostLoaded { spots: ${spots.length}, hasReachedMax: $hasReachedMax }';
}