import 'dart:convert';
import 'dart:ffi';

import 'package:elcity/resources/api_provider.dart';
import 'package:elcity/resources/location_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

class SpotRepository {
  final _apiProvider = ApiProvider();
  final _locationRepository = LocationRepository();
   Client client = Client();


    Future fetchSpots(lon, lan, double index) async {

    final storage = FlutterSecureStorage();
    var token = await storage.read(key: 'token');
     print(token);
    int page = index.toInt();
    final response = await client.post(
      _apiProvider.url+'spotter/spots',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'JWT '+token
      },
      body: jsonEncode(
        {
          "lon" : lon,
          "lat" : lan
        }
      )
      );
     
    return response;
  }
  
  Future postSpot(String content, String user, String city) async {
    final storage = FlutterSecureStorage();
    var token = await storage.read(key: 'token');
   
    final response = await client.post(
      _apiProvider.url+'spotter/',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'JWT '+token
      },
      body: jsonEncode(
        {
          "content": content,
          "city": "bia"
        }
      )
      );
  }

  Future getSpots(double index) async {
    Position position = await _locationRepository.getCurrentLocation();
    final resp = await fetchSpots(position.longitude, position.latitude, index);
    // print(position.longitude.toString() +" "+ position.latitude.toString());
    return resp;
    
  }
  
}