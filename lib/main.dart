import 'package:flutter/material.dart';

import 'package:chat_app/src/routes/app_routes.dart';

void main() {
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: AppRoutes.LOGIN,
      routes: AppRoutes.getAppRoutes(),
    );
  }
}
