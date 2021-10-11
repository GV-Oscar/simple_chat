import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:chat/global/environment.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;

  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;

  /// Conectar con socket
  void connect() async {
    final token = await AuthService.getToken();

    // Dart client
    this._socket = IO.io(
        Environment.socketUrl,
        IO.OptionBuilder()
            .setTransports(['websocket']) // para Flutter o Dart VM
            .enableAutoConnect() // deshabilita la conexión automática
            .enableForceNew() // forzar nueva sesion
            .setExtraHeaders({'x-token': '$token'})
            .build());

    this._socket.onConnecting((data) {
      print('onConnecting');
      _serverStatus = ServerStatus.Connecting;
      notifyListeners();
    });

    this._socket.onConnect((data) {
      print('onConnect : $data');
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    this._socket.onDisconnect((_) {
      print('onDisconnect');
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    this._socket.onConnectTimeout((data) {
      print('onConnectTimeout : $data');
    });

    this._socket.onConnectError((data) {
      print('onConnectError : $data');
    });

    this._socket.onReconnect((data) {
      print('onReconnect : $data');
    });

    this._socket.onReconnectError((data) {
      print('onReconnectError : $data');
    });

    this._socket.onReconnectFailed((data) {
      print('onReconnectFailed : $data');
    });

    this._socket.onReconnectAttempt((data) {
      print('onReconnectAttempt : $data');
    });
  }

  void disconnect() {
    this._socket.disconnect();
  }
}
