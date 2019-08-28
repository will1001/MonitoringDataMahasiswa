import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FormEditDataNilai extends StatefulWidget {
  FormEditDataNilai({this.kelas,this.kode_mk,this.nilai,this.nim,this.thn_ajar,this.index});
  final String kelas;
  final String kode_mk;
  final String nilai;
  final String nim;
  final String thn_ajar;
  final index;
  @override
  _FormEditDataNilaiState createState() => _FormEditDataNilaiState();
}

class _FormEditDataNilaiState extends State<FormEditDataNilai> {


 String _kelas,_kode_mk,_nilai,_nim,_thn_ajar;
 TextEditingController controllerkelas;
 TextEditingController controllerkode_mk;
 TextEditingController controllernilai;
 TextEditingController controllernim;
 TextEditingController controllerthn_ajar;

  void _editdata() {
    Firestore.instance.runTransaction((Transaction transaction)async{
      DocumentSnapshot snapshot = 
      await transaction.get(widget.index);
      await transaction.update(snapshot.reference,{
        "kelas":_kelas,
        "kode_mk":_kode_mk,
        "nilai":_nilai,
        "nim":_nim,
        "thn_ajar":_thn_ajar,
      });
    });
    Navigator.pop(context);
  }
 

  @override
  void initState(){
    super.initState();
    controllerkelas = TextEditingController(text: widget.kelas);
    controllerkode_mk = TextEditingController(text: widget.kode_mk);
    controllernilai = TextEditingController(text: widget.nilai);
    controllernim = TextEditingController(text: widget.nim);
    controllerthn_ajar = TextEditingController(text: widget.thn_ajar);
    _kelas = widget.kelas;
    _kode_mk = widget.kode_mk;
    _nilai = widget.nilai;
    _nim = widget.nim;
    _thn_ajar = widget.thn_ajar;
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
             controller: controllerkelas,
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
             controller: controllerkode_mk,
             onChanged: (String str){
               setState(() {
                 _kode_mk=str;
               });
             },
             
             decoration: InputDecoration(
               icon: Icon(Icons.format_list_numbered_rtl),
               hintText: "KODE MK"
             ),
           ),
           TextField(
             controller: controllernilai,
             onChanged: (String str){
               setState(() {
                 _nilai=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.event_note),
               hintText: "NILAI"
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
               icon: Icon(Icons.info_outline),
               hintText: "NIM"
             ),
           ),
           TextField(
             controller: controllerthn_ajar,
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
             onPressed: _editdata,
           ),
          ],
        ),
      ),
    );
  }
}