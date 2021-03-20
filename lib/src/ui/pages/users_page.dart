import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SmartRefresher(
          onRefresh: _onRefresh,
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

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        'Usuario',
        style: TextStyle(color: Colors.black54),
      ),
      elevation: 1.0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(Icons.exit_to_app, color: Colors.black54),
        onPressed: () {},
      ),
      actions: [
        // Container(
        //   margin: EdgeInsets.only(right: 10.0),
        //   child: socketService.serverStatus == ServerStatus.Online
        //       ? Icon(Icons.check_circle, color: Colors.green[300])
        //       : Icon(Icons.error, color: Colors.red[300]),
        // )
      ],
    );
  }

  ListView _body() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, index) => _userListTile(),
      separatorBuilder: (_, index) => Divider(),
      itemCount: 4,
    );
  }

  ListTile _userListTile() {
    return ListTile(
      title: Text("Usuario"),
      subtitle: Text("example@email.com"),
      leading: CircleAvatar(
        child: Text("Us"),
        backgroundColor: Colors.blue[100],
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: Colors.green[400]),
      ),
    );
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }
}
