import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:elcity/blocs/spot/spot_event.dart';
import 'package:elcity/blocs/spot/spot_state.dart';
import 'package:elcity/models/spots.dart';
import 'package:elcity/models/user.dart';
import 'package:elcity/resources/api_provider.dart';
import 'package:elcity/resources/spot_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class SpotBloc extends Bloc<SpotEvent, SpotState> {
  final http.Client httpClient;
  final spotRepository = SpotRepository();
  final _apiProvider = ApiProvider();

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
    if ((event is Fetch && !_hasReachedMax(currentState)) ||
        event is ForceRefresh) {
      try {
        if ((currentState is SpotUninitialized) || 
            event is ForceRefresh || 
            currentState is SpotError) {
          final resp = await _fetchSpots(_apiProvider.url + 'spotter/spots');
          final spots = resp[2];

          yield (resp[1] == null)
          ? SpotLoaded(
              spots: spots,
              hasReachedMax: true,
              nextUrl: resp[1],
              count: resp[0])
          : SpotLoaded(
              spots: spots,
              hasReachedMax: false,
              nextUrl: resp[1],
              count: resp[0]);

          return;
        }
        if (currentState is SpotLoaded) {
          final resp = await _fetchSpots(currentState.nextUrl);
          final spots = resp[2];

          yield (resp[1] == null)
              ? SpotLoaded(
                  spots: currentState.spots + spots,
                  hasReachedMax: true,
                  nextUrl: resp[1])
              : SpotLoaded(
                  spots: currentState.spots + spots,
                  hasReachedMax: false,
                  nextUrl: resp[1]);
        }
      } catch (_) {
        print(_);
        yield SpotError();
      }
    }
  }

  bool _hasReachedMax(SpotState state) =>
      state is SpotLoaded && state.hasReachedMax;

  Future<List> _fetchSpots(String url) async {
    final response = await spotRepository.getSpots(url);
    if (response.statusCode == 200) {
      Map data = json.decode(response.body);

      final nextPage = data['next'];
      final maxCount = data['count'];

      List<dynamic> list = List();
      list = data['results'];

      var ins = list.map((rawSpot) {
        bool anon = rawSpot['anonymous'];

        if (anon) {
          return Spot(
              user: User("anonymous", "anonymous", "anonymous", Icons.person),
              anonymous: rawSpot['anonymous'],
              content: rawSpot['content'],
              id: rawSpot['id']);
        } else {
          return Spot(
              user: User(rawSpot['user']['email'], rawSpot['user']['username'],
                  rawSpot['user']['age'], Icons.person),
              anonymous: rawSpot['anonymous'],
              content: rawSpot['content'],
              id: rawSpot['id']);
        }
      }).toList();

      return [maxCount, nextPage, ins];
    } else {
      throw Exception('error fetching spots');
    }
  }
}
