import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FormTambahDataMahasiswaStatus extends StatefulWidget {
  FormTambahDataMahasiswaStatus({this.nim,this.status,this.tahun,this.index});
  final String nim;
  final String status;
  final String tahun;
  final index;
  @override
  _FormTambahDataMahasiswaStatusState createState() => _FormTambahDataMahasiswaStatusState();
}

class _FormTambahDataMahasiswaStatusState extends State<FormTambahDataMahasiswaStatus> {


 String _nim,_status,_tahun;

 void _adddata() {
    Firestore.instance.runTransaction((Transaction transsaction) async {
      CollectionReference reference = Firestore.instance.collection('mhs_status');
      await reference.add({
        "nim" : _nim,
        "status"  : _status,
        "tahun"  : _tahun,
      });
    });
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Mahasiswa Status'),
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
                 _status=str;
               });
             },
             
             decoration: InputDecoration(
               icon: Icon(Icons.format_list_numbered_rtl),
               hintText: "Status"
             ),
           ),
           TextField(
             onChanged: (String str){
               setState(() {
                 _tahun=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.event_note),
               hintText: "Tahun"
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