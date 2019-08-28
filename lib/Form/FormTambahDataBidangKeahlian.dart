import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FormTambahDataBidangKeahlian extends StatefulWidget {
  FormTambahDataBidangKeahlian({this.keterangan,this.kode_bk,this.nama_bk,this.index});
  final String keterangan;
  final String kode_bk;
  final String nama_bk;
  final index;
  @override
  _FormTambahDataBidangKeahlianState createState() => _FormTambahDataBidangKeahlianState();
}

class _FormTambahDataBidangKeahlianState extends State<FormTambahDataBidangKeahlian> {


 String _keterangan,_kode_bk,_nama_bk;

 void _adddata() {
    Firestore.instance.runTransaction((Transaction transsaction) async {
      CollectionReference reference = Firestore.instance.collection('bkeahlian');
      await reference.add({
        "keterangan" : _keterangan,
        "kode_bk"  : _kode_bk,
        "nama_bk"  : _nama_bk,
      });
    });
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Bidang Keahlian'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           TextField(
             onChanged: (String str){
               setState(() {
                 _keterangan=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.person),
               hintText: "Keterangan"
             ),
           ),
           TextField(
             onChanged: (String str){
               setState(() {
                 _kode_bk=str;
               });
             },
             
             decoration: InputDecoration(
               icon: Icon(Icons.format_list_numbered_rtl),
               hintText: "Kode Bidang Keahlian"
             ),
           ),
           TextField(
             onChanged: (String str){
               setState(() {
                 _nama_bk=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.event_note),
               hintText: "Nama Bidang Keahlian"
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