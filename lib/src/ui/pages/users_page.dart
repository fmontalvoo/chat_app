import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat_app/src/models/user_model.dart';

import 'package:chat_app/src/services/auth_service.dart';
import 'package:chat_app/src/services/user_service.dart';
import 'package:chat_app/src/services/chat_service.dart';
import 'package:chat_app/src/services/socket_service.dart';

import 'package:chat_app/src/routes/app_routes.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final _userService = new UserService();
  List<UserModel> _users = <UserModel>[];

  @override
  void initState() {
    this._loadUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: SmartRefresher(
          onRefresh: _loadUsers,
          enablePullDown: true,
          header: WaterDropHeader(
            complete: Icon(
              Icons.check_circle,
              color: Colors.green[400],
            ),
            waterDropColor: Colors.blue[400],
          ),
          controller: _refreshController,
          child: _body()),
    );
  }

  AppBar _appBar(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return AppBar(
      centerTitle: true,
      title: Text(
        authService.user.name,
        style: TextStyle(color: Colors.black54),
      ),
      elevation: 1.0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(Icons.exit_to_app, color: Colors.black54),
        onPressed: () {
          authService.logout();
          socketService.disconnect();
          Navigator.pushReplacementNamed(context, AppRoutes.LOGIN);
        },
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 10.0),
          child: (socketService.serverStatus == ServerStatus.Online)
              ? Icon(Icons.check_circle, color: Colors.green[300])
              : Icon(Icons.error, color: Colors.red[300]),
        )
      ],
    );
  }

  ListView _body() {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, index) => _userListTile(this._users[index]),
        separatorBuilder: (_, index) => Divider(),
        itemCount: this._users.length);
  }

  ListTile _userListTile(UserModel user) {
    return ListTile(
      title: Text(user.name),
      subtitle: Text(user.email),
      leading: CircleAvatar(
        child: Text(user.name.substring(0, 2)),
        backgroundColor: Colors.blue[100],
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: user.online ? Colors.green[400] : Colors.red[400]),
      ),
      onTap: () {
        final chatService = context.read<ChatService>();
        chatService.to = user;
        Navigator.pushNamed(context, AppRoutes.CHAT);
      },
    );
  }

  void _loadUsers() async {
    this._users = await this._userService.getUsers();
    setState(() {});
    _refreshController.refreshCompleted();
  }
}
