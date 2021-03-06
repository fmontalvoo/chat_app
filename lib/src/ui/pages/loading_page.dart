import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:chat_app/src/ui/pages/login_page.dart';
import 'package:chat_app/src/ui/pages/users_page.dart';

import 'package:chat_app/src/services/auth_service.dart';
import 'package:chat_app/src/services/socket_service.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = context.read<AuthService>();
    final socketService = context.read<SocketService>();

    final isLoggedIn = await authService.isLoggedIn();
    if (isLoggedIn) {
      socketService.coonect();
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => UsersPage(),
              transitionDuration: Duration(milliseconds: 0)));
    } else
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => LoginPage(),
              transitionDuration: Duration(milliseconds: 0)));
  }
}
