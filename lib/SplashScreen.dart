import 'package:flutter/material.dart';
import 'Login.dart';
import 'package:transparent_image/transparent_image.dart';


class SpalshScreen extends StatefulWidget {
  SpalshScreen({Key key, this.title}) : super(key: key);

  final String title;
 
  @override
  _SpalshScreenState createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {

  double _opacity;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3),
    (){
      Navigator.of(context).push(
        MaterialPageRoute(builder: (c) => Login(),));
    },
    
    );
    _opacity = _opacity == 0.0 ? 1.0 : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // AnimatedOpacity(
            //   duration: Duration(seconds: 3),
            //   opacity: _opacity,
            //   child: Text(
            //     "Data Monitoring Mahasiswa",
            //     style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23.0,color: Colors.grey[700]),
            //     ),
            // ),
            FadeInImage.memoryNetwork(
              fadeInDuration: const Duration(seconds: 3),
              placeholder: kTransparentImage,
              image: 'https://i1.wp.com/unram.ac.id/wp-content/uploads/2018/04/Logo-Unram-1.png?fit=300%2C225&ssl=1',
            ),
          ],
        )
      )
    );
  }
  
}
