import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:chat_app/src/services/auth_service.dart';
import 'package:chat_app/src/services/chat_service.dart';
import 'package:chat_app/src/services/socket_service.dart';

import 'package:chat_app/src/ui/widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final String event = 'private-chat';

  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  SocketService _socketService;
  ChatService _chatService;
  AuthService _authService;

  List<ChatMessage> mensajes = <ChatMessage>[];
  bool _escribiendo = false;

  @override
  void initState() {
    this._chatService = context.read<ChatService>();
    this._socketService = context.read<SocketService>();
    this._authService = context.read<AuthService>();

    this._socketService.socket.on(event, _listenMessage);

    _loadMessages(this._chatService.to.uid);

    super.initState();
  }

  void _listenMessage(dynamic payload) {
    final chat = ChatMessage(
      uid: payload['from'],
      message: payload['message'],
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 500)),
    );

    setState(() {
      mensajes.insert(0, chat);
    });

    chat.animationController.forward();
  }

  void _loadMessages(String uid) async {
    final chats = await this._chatService.getChat(uid);
    final history = chats.map((chat) => ChatMessage(
          uid: chat.from,
          message: chat.message,
          animationController: AnimationController(
              vsync: this, duration: Duration(milliseconds: 100))
            ..forward(),
        ));

    setState(() {
      this.mensajes.insertAll(0, history);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(this._chatService.to.name),
      body: _body(),
    );
  }

  AppBar _appBar(String name) {
    return AppBar(
        elevation: 1.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: BackButton(color: Colors.black54),
        title: Text(
          name,
          style: TextStyle(color: Colors.black54),
        ));
  }

  Widget _body() {
    return Container(
      child: Column(
        children: [
          Flexible(
              child: ListView.builder(
            reverse: true,
            physics: BouncingScrollPhysics(),
            itemCount: mensajes.length,
            itemBuilder: (BuildContext context, int index) => mensajes[index],
          )),
          Divider(height: 1.0),
          Container(
            height: 70.0,
            color: Colors.white,
            child: _inputChat(),
          )
        ],
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
                child: TextField(
              decoration:
                  InputDecoration.collapsed(hintText: "Escribir mensaje"),
              focusNode: _focusNode,
              controller: _controller,
              onSubmitted: _submit,
              onChanged: (texto) {
                setState(() {
                  if (texto.trim().length > 0)
                    _escribiendo = true;
                  else
                    _escribiendo = false;
                });
              },
            )),
            if (Platform.isAndroid)
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: IconTheme(
                  data: IconThemeData(color: Colors.blue[400]),
                  child: IconButton(
                      icon: Icon(
                        Icons.send,
                      ),
                      onPressed: !_escribiendo
                          ? null
                          : () => _submit(_controller.text.trim())),
                ),
              ),
            if (Platform.isIOS)
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: CupertinoButton(
                    child: Text("Enviar"),
                    onPressed: !_escribiendo
                        ? null
                        : () => _submit(_controller.text.trim())),
              )
          ],
        ),
      ),
    );
  }

  void _submit(String mensaje) {
    if (mensaje.isEmpty) return;

    _controller.clear();
    _focusNode.requestFocus();

    setState(() {
      final chat = ChatMessage(
        uid: this._authService.user.uid,
        message: mensaje,
        animationController: AnimationController(
            vsync: this, duration: Duration(milliseconds: 500)),
      );
      chat.animationController.forward();
      mensajes.insert(0, chat);
      _escribiendo = false;
    });

    this._socketService.socket.emit(event, {
      'from': this._authService.user.uid,
      'to': this._chatService.to.uid,
      'message': mensaje
    });
  }

  @override
  void dispose() {
    for (ChatMessage chat in mensajes) chat.animationController.dispose();
    this._socketService.socket.off(event);
    super.dispose();
  }
}
