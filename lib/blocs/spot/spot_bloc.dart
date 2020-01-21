import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:elcity/blocs/spot/spot_event.dart';
import 'package:elcity/blocs/spot/spot_state.dart';
import 'package:elcity/models/spots.dart';
import 'package:elcity/models/user.dart';
import 'package:elcity/resources/spot_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class SpotBloc extends Bloc<SpotEvent, SpotState> {
  final http.Client httpClient;
  final spotRepository = SpotRepository();
  SpotBloc({@required this.httpClient});

  @override
  Stream<SpotState> transformEvents(
    Stream<SpotEvent> events,
    Stream<SpotState> Function(SpotEvent event) next,
  ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  get initialState => SpotUninitialized();

  @override
  Stream<SpotState> mapEventToState(SpotEvent event) async* {
    final currentState = state;
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is SpotUninitialized) {
          final spots = await _fetchSpots(10);

          yield SpotLoaded(spots: spots, hasReachedMax: false);

          return;
        }
        if (currentState is SpotLoaded) {
          final spots = await _fetchSpots(currentState.spots.length);
          yield spots.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : SpotLoaded(
                  spots: currentState.spots + spots,
                  hasReachedMax: false,
                );
        }
      } catch (_) {
        print(_);
        yield SpotError();
      }
    }
  }

  bool _hasReachedMax(SpotState state) =>
      state is SpotLoaded && state.hasReachedMax;

  Future<List<Spot>> _fetchSpots(int index) async {
    final response = await spotRepository.getSpots(index/10);
    if (response.statusCode == 200) {

      Map data = json.decode(response.body);
      List<dynamic> list = List();
      list = data['results'];
     
    

      var ins = list.map((rawSpot) {
        
        bool anon = rawSpot['anonymous'];
        if (anon) {
          return Spot(
            user: User(
            "anonymous",
            "anonymous", 
            "anonymous" 
            ),
            anonymous: rawSpot['anonymous'],
            content: rawSpot['content'],
          );
        } else {
          return Spot(
            user: User(rawSpot['user']['email'], rawSpot['user']['username'],
                rawSpot['user']['age']),
            anonymous: rawSpot['anonymous'],
            content: rawSpot['content'],
          );
        }
      }).toList();
      return ins;
    } else {
      throw Exception('error fetching spots');
    }
  }
}
