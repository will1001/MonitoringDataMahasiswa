import 'package:flutter/material.dart';

import 'Login.dart';


class SpalshScreen extends StatefulWidget {
  SpalshScreen({Key key, this.title}) : super(key: key);

  final String title;
 
  @override
  _SpalshScreenState createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3),
    (){
      Navigator.of(context).push(
        MaterialPageRoute(builder: (c) => Login(),));
    },
    
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FlutterLogo(
          size: 400,
        )
      )
    );
  }
  
}
