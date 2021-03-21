import 'dart:convert';

import 'package:chat_app/src/models/user_model.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat_app/src/models/user_credential.dart';

import 'package:chat_app/src/global/environments.dart';

class AuthService with ChangeNotifier {
  UserModel _user;
  bool _autenticando = false;

  final _storage = new FlutterSecureStorage();

  bool get autenticando => this._autenticando;
  set autenticando(bool value) {
    this._autenticando = value;
    notifyListeners();
  }

  UserModel get user => this._user;

  Future<String> getToken() async {
    final storage = new FlutterSecureStorage();
    final token = await storage.read(key: 'jwt');
    return token;
  }

  Future<UserCredential> login(String email, String password) async {
    this.autenticando = true;
    final credentials = {
      'email': email,
      'password': password,
    };
    final response = await http.post('${Environments.API_URL}/auth/signin',
        body: jsonEncode(credentials),
        headers: {'Content-type': 'application/json'});

    this.autenticando = false;
    if (response.statusCode == 200) {
      final credential = userCredentialFromJson(response.body);
      await this._guardarToken(credential.token);
      this._user = credential.user;
      return credential;
    }
    return null;
  }

  Future<UserCredential> signup(
      String name, String email, String password) async {
    this.autenticando = true;
    final userData = {
      'name': name,
      'email': email,
      'password': password,
    };
    final response = await http.post('${Environments.API_URL}/auth/signup',
        body: jsonEncode(userData),
        headers: {'Content-type': 'application/json'});

    this.autenticando = false;
    if (response.statusCode == 200) {
      final credential = userCredentialFromJson(response.body);
      await this._guardarToken(credential.token);
      this._user = credential.user;
      return credential;
    }
    return null;
  }

  Future<bool> isLoggedIn() async {
    final token = await this._storage.read(key: 'jwt');
    final response = await http.get('${Environments.API_URL}/auth/renew',
        headers: {'Content-type': 'application/json', 'x-token': token});

    if (response.statusCode == 200) {
      final credential = userCredentialFromJson(response.body);
      await this._guardarToken(credential.token);
      this._user = credential.user;
      return true;
    } else {
      this.logout();
      return false;
    }
  }

  Future _guardarToken(String token) async {
    return await this._storage.write(key: 'jwt', value: token);
  }

  Future<void> logout() async {
    this._storage.delete(key: 'jwt');
  }
}
