import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 1.0,
      centerTitle: true,
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            child: Text("Us"),
            radius: 20.0,
            backgroundColor: Colors.blue[100],
          ),
          SizedBox(width: 5.0),
          Text(
            "Usuario",
            style: TextStyle(color: Colors.black54),
          )
        ],
      ),
    );
  }

  Widget _body() {
    return Container(
      child: Column(
        children: [
          Flexible(
              child: ListView.builder(
            reverse: true,
            physics: BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) => Text('$index'),
          )),
          Divider(height: 1.0),
          Container(
            height: 70.0,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
