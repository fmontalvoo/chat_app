import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:chat_app/src/models/user_model.dart';

import 'package:chat_app/src/services/auth_service.dart';

import 'package:chat_app/src/global/environments.dart';

class UserService {
  Future<List<UserModel>> getUsers() async {
    try {
      final token = await AuthService.getToken();
      final response = await http.get('${Environments.API_URL}/users',
          headers: {'Content-type': 'application/json', 'x-token': token});
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        final users = List<UserModel>.from(
            data['users'].map((user) => UserModel.fromJson(user)));
        return users;
      }
    } catch (e) {
      return [];
    }
    return [];
  }
}
