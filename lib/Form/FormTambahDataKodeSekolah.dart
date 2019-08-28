import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FormTambahDataKodeSekolah extends StatefulWidget {
  FormTambahDataKodeSekolah({this.id_sekolah,this.keterangan,this.nama_sekolah,this.index});
  final String id_sekolah;
  final String keterangan;
  final String nama_sekolah;
  final index;
  @override
  _FormTambahDataKodeSekolahState createState() => _FormTambahDataKodeSekolahState();
}

class _FormTambahDataKodeSekolahState extends State<FormTambahDataKodeSekolah> {


 String _id_sekolah,_keterangan,_nama_sekolah;

 void _adddata() {
    Firestore.instance.runTransaction((Transaction transsaction) async {
      CollectionReference reference = Firestore.instance.collection('kode_sekolah');
      await reference.add({
        "id_sekolah" : _id_sekolah,
        "keterangan"  : _keterangan,
        "nama_sekolah"  : _nama_sekolah,
      });
    });
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Kode Sekolah'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           TextField(
             onChanged: (String str){
               setState(() {
                 _id_sekolah=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.person),
               hintText: "ID Sekolah"
             ),
           ),
           TextField(
             onChanged: (String str){
               setState(() {
                 _keterangan=str;
               });
             },
             
             decoration: InputDecoration(
               icon: Icon(Icons.format_list_numbered_rtl),
               hintText: "Keterangan"
             ),
           ),
           TextField(
             onChanged: (String str){
               setState(() {
                 _nama_sekolah=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.event_note),
               hintText: "Nama Sekolah"
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