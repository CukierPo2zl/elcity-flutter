import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:elcity/blocs/myspot/myspot.dart';
import 'package:elcity/models/spots.dart';
import 'package:elcity/models/user.dart';
import 'package:elcity/resources/api_provider.dart';
import 'package:elcity/resources/spot_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class MySpotBloc extends Bloc<MySpotEvent, MySpotState> {
  
  final http.Client httpClient;
  final _spotRepository = SpotRepository();
  final _apiProvider = ApiProvider();

  MySpotBloc({@required this.httpClient});

 @override
  Stream<MySpotState> transformEvents(
    Stream<MySpotEvent> events,
    Stream<MySpotState> Function(MySpotEvent event) next,
  ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  get initialState => MySpotUninitialized();

  @override
  Stream<MySpotState> mapEventToState(MySpotEvent event) async* {
    final currentState = state;
    if(event is Fetch){
      try {
        if(currentState is MySpotUninitialized){
          final response = await _spotRepository.getMySpots(_apiProvider.url+'spotter/');
          if(response.statusCode == 200) {
            List data = json.decode(response.body);

            List<dynamic> list = List();
            list = data;
            final myspots = list.map((rawSpot){
              return Spot(
                user: User(rawSpot['email'], rawSpot['username'], rawSpot['age'], Icons.person),
                anonymous: rawSpot['anonymous'],
                content: rawSpot['content'],
                id: rawSpot['id']
              );
            }).toList();
          
            
          yield MySpotLoaded(
            spots: myspots, 

          );
          }
          return;
        }

      } catch(_){
        print(_);
        yield MySpotError();
      }
    }
    
  }

  
}