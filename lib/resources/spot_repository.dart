import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:elcity/resources/api_provider.dart';
import 'package:elcity/resources/location_repository.dart';
import 'package:elcity/resources/user_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

class SpotRepository {
  final _locationRepository = LocationRepository();
  final _userRepository = UserRepository();
  Client client = Client();

  Future fetchSpots(url, lon, lan) async {
    // final storage = FlutterSecureStorage();
    // var token = await storage.read(key: 'token');

    var token = await _userRepository.getToken();
   

    final response = await client.post(url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'JWT ' + token
        },
        body: jsonEncode({"lon": lon, "lat": lan}));

    return response;
  }

  Future getSpots(String url) async {
    Position position = await _locationRepository.getCurrentLocation();
    final resp = await fetchSpots(url, position.longitude, position.latitude);

    return resp;
  }

  Future getMySpots(String url) async {
    var token = await _userRepository.getToken();
   
    final resp = await client.get(url,
      headers: {
        'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'JWT ' + token
       
      },
    );
     return resp;
   
    

   
  }
}