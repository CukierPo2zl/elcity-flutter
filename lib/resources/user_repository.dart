import 'package:elcity/resources/api_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

class UserRepository {
  final _apiProvider = ApiProvider();

  Future<String> authenticate({
    @required String email,
    @required String password,
  }) async {
    await _apiProvider.signinUser(email, password);
    final storage = FlutterSecureStorage();
    return await storage.read(key: 'token');;
  }

  Future<void> deleteToken() async {
    final storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  }

  persistToken(String token) async {
    _apiProvider.saveApiKey(token);
  }

  Future<bool> hasToken() async {
    // read from keystore/keychain
    final storage = FlutterSecureStorage();
    if(await storage.read(key: 'token') != null ){
      return true;
    };
    return false;
  }

  getToken() async {
    final storage = FlutterSecureStorage();
    return await storage.read(key: 'token');
  }
}