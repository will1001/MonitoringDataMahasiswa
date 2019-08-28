import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FormTambahDataKodeNilai extends StatefulWidget {
  FormTambahDataKodeNilai({this.angka,this.huruf,this.keterangan,this.index});
  final String angka;
  final String huruf;
  final String keterangan;
  final index;
  @override
  _FormTambahDataKodeNilaiState createState() => _FormTambahDataKodeNilaiState();
}

class _FormTambahDataKodeNilaiState extends State<FormTambahDataKodeNilai> {


 String _angka,_huruf,_keterangan;

 void _adddata() {
    Firestore.instance.runTransaction((Transaction transsaction) async {
      CollectionReference reference = Firestore.instance.collection('kode_nilai');
      await reference.add({
        "angka" : _angka,
        "huruf"  : _huruf,
        "keterangan"  : _keterangan,
      });
    });
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Kode Nilai'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           TextField(
             onChanged: (String str){
               setState(() {
                 _angka=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.person),
               hintText: "Angka"
             ),
           ),
           TextField(
             onChanged: (String str){
               setState(() {
                 _huruf=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.person),
               hintText: "Huruf"
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