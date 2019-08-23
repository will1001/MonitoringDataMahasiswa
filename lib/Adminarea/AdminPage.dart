import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'DataMahasiswa.dart';
import 'Datadosen.dart';
import 'Datamatakuliah.dart';
import 'Datanilai.dart';



class Adminpage extends StatefulWidget {
  @override
  _AdminpageState createState() => _AdminpageState();
}

class _AdminpageState extends State<Adminpage> {
  
@override
  void initState() {
    super.initState();
    getUID();
    
  }  

String _dataku;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('admin'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           RaisedButton(
             child: Text('Data mahasiswa'),
             color: Colors.red,
             splashColor: Colors.blue,
             onPressed: (){
               Navigator.of(context).push(
                  MaterialPageRoute(builder: (c) => DataMahasiswa())
                );
             },
           ),
           RaisedButton(
             child: Text('Data Dosen'),
             color: Colors.red,
             splashColor: Colors.blue,
             onPressed: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (c) => Datadosen())
                );
             },
           ),
           RaisedButton(
             child: Text('Data Mata Kuliah'),
             color: Colors.red,
             splashColor: Colors.blue,
             onPressed: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (c) => Datamatakuliah())
                );
             },
           ),
           RaisedButton(
             child: Text('Data Nilai'),
             color: Colors.red,
             splashColor: Colors.blue,
             onPressed: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (c) => Datanilai())
                );
             },
           ),
          ],
        ),
      ),
    );
  }


  getUID() async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user = await _auth.currentUser();
  String uid = user.uid;
  _dataku = uid;
   return  uid;
  }



  

}