import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FormTambahDataNilai extends StatefulWidget {
  FormTambahDataNilai({this.kelas,this.kode_mk,this.nilai,this.nim,this.thn_ajar,this.index});
  final String kelas;
  final String kode_mk;
  final String nilai;
  final String nim;
  final String thn_ajar;
  final index;
  @override
  _FormTambahDataNilaiState createState() => _FormTambahDataNilaiState();
}

class _FormTambahDataNilaiState extends State<FormTambahDataNilai> {


 String _kelas,_kode_mk,_nilai,_nim,_thn_ajar;

 void _adddata() {
    Firestore.instance.runTransaction((Transaction transsaction) async {
      CollectionReference reference = Firestore.instance.collection('nilai');
      await reference.add({
        "kelas" : _kelas,
        "kode_mk"  : _kode_mk,
        "nilai"  : _nilai,
        "nim"  : _nim,
        "thn_ajar"  : _thn_ajar,
      });
    });
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Nilai'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           TextField(
             onChanged: (String str){
               setState(() {
                 _kelas=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.person),
               hintText: "Kelas"
             ),
           ),
           TextField(
             onChanged: (String str){
               setState(() {
                 _kode_mk=str;
               });
             },
             
             decoration: InputDecoration(
               icon: Icon(Icons.format_list_numbered_rtl),
               hintText: "Kode MK"
             ),
           ),
           TextField(
             onChanged: (String str){
               setState(() {
                 _nilai=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.event_note),
               hintText: "Nilai"
             ),
           ),
           TextField(
             onChanged: (String str){
               setState(() {
                 _nim=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.info_outline),
               hintText: "Nim"
             ),
           ),
           TextField(
             onChanged: (String str){
               setState(() {
                 _thn_ajar=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.info_outline),
               hintText: "Tahun Ajar"
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