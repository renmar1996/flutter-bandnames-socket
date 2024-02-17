import 'dart:developer' as log;
import 'dart:math';

import 'package:flutter/material.dart';

import '../models/band_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  final controller= TextEditingController();
  List<BandModel> bands=[
  BandModel(id: '1',name: 'Queen',votes: 9),
  BandModel(id: '2',name: 'Metallica',votes: 5),
  BandModel(id: '3',name: 'Bon Jovi',votes: 8),
  BandModel(id: '4',name: 'Linkin Park',votes: 10),
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        automaticallyImplyLeading: true,
        //backgroundColor: Colors.blue,
        title:const Center(child: Text('Band Names'),) 
      ),
      body:ListView.builder(
          itemCount: bands.length,
          itemBuilder: (BuildContext context, int index) =>_bandTitle(bands[index])
        ),
        floatingActionButton: FloatingActionButton(onPressed:(){
          showDialog(
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
          },);
        },backgroundColor: Colors.blue,child: const Icon(Icons.add,color: Colors.white,),),
    );
  }

  Widget _bandTitle(BandModel band) {
    return Dismissible(
      onDismissed: (direction) {
        log.log('Este es el id a eliminar==> ${band.id}');
        //TODO: Aqui se mandaria a eliminar la banda por id en el servidor
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
                log.log(band.name!);
              },
              ),
    );
  }
  
 
 addNewband(String bandName){
    if(bandName.isNotEmpty){
      bands.add(BandModel(id: (Random().nextInt(8) + 50).toString(),name: bandName,votes: 0));
      log.log('Banda agregada $bandName');
      setState(() {});
    }
  }
}
