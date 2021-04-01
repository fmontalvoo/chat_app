import 'package:chat_app/src/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:chat_app/src/global/environments.dart';

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;

  IO.Socket get socket => this._socket;

  void coonect() async {
    final token = await AuthService.getToken();

    this._socket = IO.io(
        Environments.SOCKET_URL,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .enableForceNew()
            .setExtraHeaders({'x-token': token})
            .build());

    this._socket.onConnect((_) {
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    this._socket.onDisconnect((_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    socket.on('', (data) => null);
  }

  void disconnect() => this._socket.disconnect();
}
