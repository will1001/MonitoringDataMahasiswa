import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FormEditDataMahasiswa extends StatefulWidget {
  FormEditDataMahasiswa({this.nama,this.nim,this.thn_masuk,this.ket,this.index});
  final String nama;
  final String nim;
  final String thn_masuk;
  final String ket;
  final index;
  @override
  _FormEditDataMahasiswaState createState() => _FormEditDataMahasiswaState();
}

class _FormEditDataMahasiswaState extends State<FormEditDataMahasiswa> {


 String _nama,_nim,_thn_masuk,_ket;
 TextEditingController controllernama;
 TextEditingController controllernim;
 TextEditingController controllerthn_masuk;
 TextEditingController controllerket;

  void _editdata() {
    Firestore.instance.runTransaction((Transaction transaction)async{
      DocumentSnapshot snapshot = 
      await transaction.get(widget.index);
      await transaction.update(snapshot.reference,{
        "nama":_nama,
        "nim":_nim,
        "thn_masuk":_thn_masuk,
        "ket":_ket,
      });
    });
    Navigator.pop(context);
  }
 

  @override
  void initState(){
    super.initState();
    controllernama = TextEditingController(text: widget.nama);
    controllernim = TextEditingController(text: widget.nim);
    controllerthn_masuk = TextEditingController(text: widget.thn_masuk);
    controllerket = TextEditingController(text: widget.ket);
    _nama = widget.nama;
    _nim = widget.nim;
    _thn_masuk = widget.thn_masuk;
    _ket = widget.ket;
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
             controller: controllernama,
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
             controller: controllernim,
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
             controller: controllerthn_masuk,
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
             controller: controllerket,
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
             onPressed: _editdata,
           ),
          ],
        ),
      ),
    );
  }
}