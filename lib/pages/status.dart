import 'dart:developer' as log;

import 'package:band_names/providers/socket_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatusPage extends StatelessWidget {
   const StatusPage({super.key});


  @override
  Widget build(BuildContext context) {
  final socketService= Provider.of<SocketProvider>(context);
  final socket= socketService.socket;
    return Scaffold(
      appBar: AppBar(
        title:const Center(child: Text('Status Page')),
        elevation: 2.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Center(child: Text('${socketService.serverStatus}')),
      ],),
      floatingActionButton: FloatingActionButton(
        elevation: 1.0,
        backgroundColor: Colors.black,
        onPressed: (){
        socket.emit('enviando-mensaje',[
          {'nombre':'Rene'},
          {'edad':'27'}
          ]);
        log.log('Se emitió un mensaje al servidor');
      },child: const Icon(Icons.message,color: Colors.white,),),
    );
  }
}
