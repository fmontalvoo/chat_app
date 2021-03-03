import 'package:flutter/material.dart';

import 'package:chat_app/src/pages/chat_page.dart';
import 'package:chat_app/src/pages/login_page.dart';
import 'package:chat_app/src/pages/users_page.dart';
import 'package:chat_app/src/pages/loading_page.dart';
import 'package:chat_app/src/pages/register_page.dart';

class AppRoutes {
  static const String LOGIN = 'login';
  static const String REGISTER = 'register';
  static const String USERS = 'users';
  static const String CHAT = 'chat';
  static const String LOADING = 'loading';

  static Map<String, WidgetBuilder> getAppRoutes() {
    return {
      LOGIN: (_) => LoginPage(),
      REGISTER: (_) => RegisterPage(),
      USERS: (_) => UsersPage(),
      CHAT: (_) => ChatPage(),
      LOADING: (_) => LoadingPage()
    };
  }
}
