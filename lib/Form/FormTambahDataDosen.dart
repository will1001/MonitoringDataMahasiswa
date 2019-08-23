import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FormTambahDataDosen extends StatefulWidget {
  FormTambahDataDosen({this.id_dosen,this.nama_dosen,this.nip,this.index});
  final String id_dosen;
  final String nama_dosen;
  final String nip;
  final index;
  @override
  _FormTambahDataDosenState createState() => _FormTambahDataDosenState();
}

class _FormTambahDataDosenState extends State<FormTambahDataDosen> {


 String _id_dosen,_nama_dosen,_nip;

 void _adddata() {
    Firestore.instance.runTransaction((Transaction transsaction) async {
      CollectionReference reference = Firestore.instance.collection('dosen');
      await reference.add({
        "id_dosen" : _id_dosen,
        "nama_dosen"  : _nama_dosen,
        "nip"  : _nip,
      });
    });
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Dosen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           TextField(
             onChanged: (String str){
               setState(() {
                 _id_dosen=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.person),
               hintText: "ID Dosen"
             ),
           ),
           TextField(
             onChanged: (String str){
               setState(() {
                 _nama_dosen=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.person),
               hintText: "Nama Dosen"
             ),
           ),
           TextField(
             onChanged: (String str){
               setState(() {
                 _nip=str;
               });
             },
             
             decoration: InputDecoration(
               icon: Icon(Icons.format_list_numbered_rtl),
               hintText: "nip"
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