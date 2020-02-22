import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'dart:convert';


class ApiProvider {
  Client client = Client();
  final String url ="http://192.168.0.13:8000/api/";

  Future signinUser(String email, String password) async {
    final response = await client
        .post(url+"users/auth/login/",
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json' 
        },
        body: jsonEncode(
          {
	          "email" : email,
	          "password" : password,
        }
        ) 
        );
    final Map result = json.decode(response.body);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      await saveApiKey(result['token']);
      // await setUser(result['user']);
     
    } else {
      // If that call was not successful, throw an error.
      throw Exception('error');
    }
  }

  saveApiKey(String token) async {
    final storage = FlutterSecureStorage();
    await storage.write(key: 'token', value: token);
  }



}