import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat_app/src/routes/app_routes.dart';

import 'package:chat_app/src/services/auth_service.dart';

void main() {
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
      ],
      child: MaterialApp(
        title: 'Chat App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: AppRoutes.LOADING,
        routes: AppRoutes.getAppRoutes(),
      ),
    );
  }
}
