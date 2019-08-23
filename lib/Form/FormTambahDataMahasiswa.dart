import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FormTambahDataMahasiswa extends StatefulWidget {
  FormTambahDataMahasiswa({this.nama,this.nim,this.thn_masuk,this.ket,this.index});
  final String nama;
  final String nim;
  final String thn_masuk;
  final String ket;
  final index;
  @override
  _FormTambahDataMahasiswaState createState() => _FormTambahDataMahasiswaState();
}

class _FormTambahDataMahasiswaState extends State<FormTambahDataMahasiswa> {


 String _nama,_nim,_thn_masuk,_ket;

 void _adddata() {
    Firestore.instance.runTransaction((Transaction transsaction) async {
      CollectionReference reference = Firestore.instance.collection('mahasiswa');
      await reference.add({
        "nama" : _nama,
        "nim"  : _nim,
        "_thn_masuk"  : _thn_masuk,
        "_ket"  : _ket,
      });
    });
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Mahasiswa'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           TextField(
             onChanged: (String str){
               setState(() {
                 _nama=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.person),
               hintText: "nama"
             ),
           ),
           TextField(
             onChanged: (String str){
               setState(() {
                 _nim=str;
               });
             },
             
             decoration: InputDecoration(
               icon: Icon(Icons.format_list_numbered_rtl),
               hintText: "nim"
             ),
           ),
           TextField(
             onChanged: (String str){
               setState(() {
                 _thn_masuk=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.event_note),
               hintText: "Tahun Masuk"
             ),
           ),
           TextField(
             onChanged: (String str){
               setState(() {
                 _ket=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.info_outline),
               hintText: "Keterangan"
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