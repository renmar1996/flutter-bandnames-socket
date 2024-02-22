
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import 'dart:developer'as log;

enum ServerStatus{
  // ignore: constant_identifier_names
  Connecting,
  // ignore: constant_identifier_names
  Online,
  // ignore: constant_identifier_names
  Offline,
}

class SocketProvider with ChangeNotifier{

final io.Socket _socket = io.io('http://192.168.42.71:3000', io.OptionBuilder()
      .setTransports(['websocket']) // for Flutter or Dart VM
      .enableAutoConnect()  // enable auto-connection
      .build());

io.Socket get socket=> _socket;

ServerStatus _serverStatus= ServerStatus.Connecting;
ServerStatus get serverStatus=> _serverStatus;

SocketProvider(){
  _initProvider();
}

  void _initProvider(){
    // Dart client
  
      
  //socket.connect();  ////// solo si disableAutoConnect esta activado
  
  socket.onConnect((_) {
    _serverStatus= ServerStatus.Online;
    notifyListeners();
    });
  socket.onDisconnect((_) {
    _serverStatus= ServerStatus.Offline;
      notifyListeners();
  });

  socket.on('nuevo-mensaje', (payload){
    log.log('El usuario se llama ${payload['nombre']}');
    log.log('Tiene ${payload['edad']} años de edad');
  });

  }

}