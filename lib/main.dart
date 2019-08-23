
import 'package:flutter/material.dart';

import 'SplashScreen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Monitoring Mahasiswa',
      theme: ThemeData(
        primarySwatch: Colors.red
      ),
      home: SpalshScreen(title: 'Data Monitoring Mahasiswa'),
    );
  }
}

