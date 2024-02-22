import 'dart:developer' as log;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/band_model.dart';
import '../providers/socket_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  final controller= TextEditingController();
  
  List<BandModel> bands=[];
  
  @override
void initState() {
  final socketService= Provider.of<SocketProvider>(context,listen:false);
    socketService.socket.on('active-bands',_handlefunctionSocket);
     
  super.initState();
  
}

_handlefunctionSocket(dynamic payload){
    
      //log.log('Estas son las bandas $payload');
    bands= (payload as List).map((banda) => BandModel.fromJson(banda)).toList();
     
     setState(() {
       
     });
  }

@override
void dispose() {
  final socketService= Provider.of<SocketProvider>(context,listen: false);
  socketService.socket.off('active-bands');
  super.dispose();
}
  

  @override
  Widget build(BuildContext context) {
    final socketService= Provider.of<SocketProvider>(context,);
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        automaticallyImplyLeading: true,
        //backgroundColor: Colors.blue,
        title:const Center(child: Text('Band Names'),), 
        actions:  [
          Container(
            padding: const EdgeInsets.only(right: 8.0),
            child: 
          socketService.serverStatus==ServerStatus.Online
          ? const Icon(Icons.online_prediction,color: Colors.green,)
          : const Icon(Icons.offline_bolt,color: Colors.red,),)
        ],
      ),
      body:ListView.builder(
          itemCount: bands.length,
          itemBuilder: (BuildContext context, int index) =>_bandTitle(bands[index])
        ),
        floatingActionButton: FloatingActionButton(onPressed:()=> showDialog(
            barrierDismissible: false,
            context: context, 
            builder: (context) {
            return AlertDialog(title: const Text('Agregar banda'),content: TextField(controller: controller,),actions: [
              TextButton(onPressed: (){
              addNewband(controller.text);
              Navigator.pop(context);
              controller.clear();
              }, child: const Text('Add')),
              TextButton(onPressed: (){
                
              Navigator.pop(context);
              controller.clear();
              }, child: const Text('Cancelar')),
            ],);
          },)
        ,backgroundColor: Colors.blue,child: const Icon(Icons.add,color: Colors.white,),),
    );
  }

  Widget _bandTitle(BandModel band) {
    final socketService= Provider.of<SocketProvider>(context,listen:false);
    return Dismissible(
      onDismissed: (direction) {
        log.log('Este es el id a eliminar==> ${band.id}');
        socketService.socket.emit('delete-band',{
          'id':band.id,
        });
       
      },
      background: Container(
        padding: const EdgeInsets.only(left: 10.0),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Icon(Icons.delete_forever,color: Colors.white,),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text('Delete band',style: TextStyle(color: Colors.white,),)),
            ],
          )),),
      direction: DismissDirection.startToEnd,
      key: Key(band.id!),
      child: ListTile(
              leading: CircleAvatar(backgroundColor: Colors.blue,child: Text(band.name!.substring(0,2),style: const TextStyle(color: Colors.white),),),
              title: Text(band.name!),
              trailing: Text(band.votes!.toString()),
              onTap: (){
                socketService.socket.emit('add-vote',{
                  'id':band.id
                });
                 setState(() {
                  
                }); 
                //log.log(band.name!);
              },
              ),
    );
  }
  
 
 addNewband(String bandName,){
  final socketService= Provider.of<SocketProvider>(context,listen:false);
    if(bandName.isNotEmpty){
      socketService.socket.emit('add-band',{
        
    'name':bandName,
    
      });
    /*   bands.add(BandModel(
        name: bandName
      )); */
                setState(() {});
      /* bands.add(BandModel(id: (Random().nextInt(8) + 50).toString(),name: bandName,votes: 0));
      log.log('Banda agregada $bandName');
      setState(() {}); */
    }
  }
}

