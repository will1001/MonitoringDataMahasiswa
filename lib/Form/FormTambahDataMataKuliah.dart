import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FormTambahDataMataKuliah extends StatefulWidget {
  FormTambahDataMataKuliah({this.kode_bk,this.kode_mk,this.nama_mk,this.semester,this.sifat,this.sks,this.keterangan,this.index});
  final String kode_bk;
  final String kode_mk;
  final String nama_mk;
  final String semester;
  final String sifat;
  final String sks;
  final String keterangan;
  final index;
  @override
  _FormTambahDataMataKuliahState createState() => _FormTambahDataMataKuliahState();
}

class _FormTambahDataMataKuliahState extends State<FormTambahDataMataKuliah> {


 String _kode_bk,_kode_mk,_nama_mk,_semester,_sifat,_sks,_keterangan;

 void _adddata() {
    Firestore.instance.runTransaction((Transaction transsaction) async {
      CollectionReference reference = Firestore.instance.collection('matakuliah');
      await reference.add({
        "kode_bk" : _kode_bk,
        "kode_mk"  : _kode_mk,
        "nama_mk"  : _nama_mk,
        "semester"  : _semester,
        "sifat"  : _sifat,
        "sks"  : _sks,
        "keterangan"  : _keterangan,
      });
    });
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Mata Kuliah'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           TextField(
             onChanged: (String str){
               setState(() {
                 _kode_bk=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.person),
               hintText: "e"
             ),
           ),
           TextField(
             onChanged: (String str){
               setState(() {
                 _kode_mk=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.person),
               hintText: "e"
             ),
           ),
           TextField(
             onChanged: (String str){
               setState(() {
                 _nama_mk=str;
               });
             },
             
             decoration: InputDecoration(
               icon: Icon(Icons.format_list_numbered_rtl),
               hintText: "e"
             ),
           ),
           TextField(
             onChanged: (String str){
               setState(() {
                 _semester=str;
               });
             },
             
             decoration: InputDecoration(
               icon: Icon(Icons.format_list_numbered_rtl),
               hintText: "e"
             ),
           ),
           TextField(
             onChanged: (String str){
               setState(() {
                 _sifat=str;
               });
             },
             
             decoration: InputDecoration(
               icon: Icon(Icons.format_list_numbered_rtl),
               hintText: "e"
             ),
           ),
           TextField(
             onChanged: (String str){
               setState(() {
                 _sks=str;
               });
             },
             
             decoration: InputDecoration(
               icon: Icon(Icons.format_list_numbered_rtl),
               hintText: "e"
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