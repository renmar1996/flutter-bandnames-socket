import 'package:band_names/pages/status.dart';
import 'package:band_names/providers/socket_provider.dart';
import 'package:flutter/material.dart';

import 'package:band_names/pages/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> SocketProvider()),
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Materia App',
        initialRoute: 'home',
        routes: {
          'home': (_)=> const HomePage(),
          'status':(_)=>  const StatusPage(),
        },
      ),
    );
  }
}




