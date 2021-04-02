import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'package:chat_app/src/models/user_model.dart';
import 'package:chat_app/src/models/chat_model.dart';

import 'package:chat_app/src/services/auth_service.dart';

import 'package:chat_app/src/global/environments.dart';

class ChatService with ChangeNotifier {
  UserModel to;

  Future<List<ChatModel>> getChat(String uid) async {
    try {
      final token = await AuthService.getToken();

      final response = await http.get('${Environments.API_URL}/chats/$uid',
          headers: {'Content-type': 'application/json', 'x-token': token});

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        final chats = List<ChatModel>.from(
            data['chats'].map((chat) => ChatModel.fromJson(chat)));

        return chats;
      }
    } catch (e) {
      return [];
    }
    return [];
  }
}
