import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FormTambahDataPengampu extends StatefulWidget {
  FormTambahDataPengampu({this.id_dosen,this.kelas,this.kode_mk,this.thn_ajar,this.index});
  final String id_dosen;
  final String kelas;
  final String kode_mk;
  final String thn_ajar;
  final index;
  @override
  _FormTambahDataPengampuState createState() => _FormTambahDataPengampuState();
}

class _FormTambahDataPengampuState extends State<FormTambahDataPengampu> {


 String _id_dosen,_kelas,_kode_mk,_thn_ajar;

 void _adddata() {
    Firestore.instance.runTransaction((Transaction transsaction) async {
      CollectionReference reference = Firestore.instance.collection('mahasiswa');
      await reference.add({
        "id_dosen" : _id_dosen,
        "kelas"  : _kelas,
        "kode_mk"  : _kode_mk,
        "thn_ajar"  : _thn_ajar,
      });
    });
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Pengampu'),
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
               hintText: "Id Dosen"
             ),
           ),
           TextField(
             onChanged: (String str){
               setState(() {
                 _kelas=str;
               });
             },
             
             decoration: InputDecoration(
               icon: Icon(Icons.format_list_numbered_rtl),
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
               icon: Icon(Icons.event_note),
               hintText: "Kode MK"
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