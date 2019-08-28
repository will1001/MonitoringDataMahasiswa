import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FormTambahDataTakhir extends StatefulWidget {
  FormTambahDataTakhir({this.nim,this.pmb1,this.pmb2,this.tgl_proposal,this.tgl_shasil,this.tgl_ujian,this.index});
  final String nim;
  final String pmb1;
  final String pmb2;
  final String tgl_proposal;
  final String tgl_shasil;
  final String tgl_ujian;
  final index;
  @override
  _FormTambahDataTakhirState createState() => _FormTambahDataTakhirState();
}

class _FormTambahDataTakhirState extends State<FormTambahDataTakhir> {


 String _nim,_pmb1,_pmb2,_tgl_proposal,_tgl_shasil,_tgl_ujian;

 void _adddata() {
    Firestore.instance.runTransaction((Transaction transsaction) async {
      CollectionReference reference = Firestore.instance.collection('takhir');
      await reference.add({
        "nim" : _nim,
        "pmb1"  : _pmb1,
        "pmb2"  : _pmb2,
        "tgl_proposal"  : _tgl_proposal,
        "tgl_shasil"  : _tgl_shasil,
        "tgl_ujian"  : _tgl_ujian,
      });
    });
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Takhir'),
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
                 _pmb1=str;
               });
             },
             
             decoration: InputDecoration(
               icon: Icon(Icons.format_list_numbered_rtl),
               hintText: "Pembimbing 1"
             ),
           ),
           TextField(
             onChanged: (String str){
               setState(() {
                 _pmb2=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.event_note),
               hintText: "Pembimbing 2"
             ),
           ),
           TextField(
             onChanged: (String str){
               setState(() {
                 _tgl_proposal=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.info_outline),
               hintText: "Tanggal Proposal"
             ),
           ),
           TextField(
             onChanged: (String str){
               setState(() {
                 _tgl_shasil=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.info_outline),
               hintText: "Tanggal Hasil"
             ),
           ),
           TextField(
             onChanged: (String str){
               setState(() {
                 _tgl_ujian=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.info_outline),
               hintText: "Tanggal Ujian"
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