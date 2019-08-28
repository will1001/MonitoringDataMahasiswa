import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FormTambahDataYudisium extends StatefulWidget {
  FormTambahDataYudisium({this.nim,this.tgl_ydsm,this.index});
  final String nim;
  final String tgl_ydsm;
  final index;
  @override
  _FormTambahDataYudisiumState createState() => _FormTambahDataYudisiumState();
}

class _FormTambahDataYudisiumState extends State<FormTambahDataYudisium> {


 String _nim,_tgl_ydsm;

 void _adddata() {
    Firestore.instance.runTransaction((Transaction transsaction) async {
      CollectionReference reference = Firestore.instance.collection('yudisium');
      await reference.add({
        "nim" : _nim,
        "tgl_ydsm"  : _tgl_ydsm,
      });
    });
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Yudisium'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           TextField(
             onChanged: (String str){
               setState(() {
                 _nim=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.person),
               hintText: "NIM"
             ),
           ),
           TextField(
             onChanged: (String str){
               setState(() {
                 _tgl_ydsm=str;
               });
             },
             
             decoration: InputDecoration(
               icon: Icon(Icons.format_list_numbered_rtl),
               hintText: "Tanggal Yudisium"
             ),
           ),
           RaisedButton(
             child: Text('Submit'),
             color: Colors.red,
             splashColor: Colors.blue,
             onPressed: _adddata,
           ),
          ],
        ),
      ),
    );
  }
}