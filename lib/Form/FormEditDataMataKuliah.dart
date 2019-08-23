import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FormEditDataMataKuliah extends StatefulWidget {
  FormEditDataMataKuliah({this.kode_bk,this.kode_mk,this.nama_mk,this.semester,this.sifat,this.sks,this.keterangan,this.index});
  final String kode_bk;
  final String kode_mk;
  final String nama_mk;
  final String semester;
  final String sifat;
  final String sks;
  final String keterangan;
  final index;
  @override
  _FormEditDataMataKuliahState createState() => _FormEditDataMataKuliahState();
}

class _FormEditDataMataKuliahState extends State<FormEditDataMataKuliah> {


 String _kode_bk,_kode_mk,_nama_mk,_semester,_sifat,_sks,_keterangan;

 TextEditingController controllerkode_bk;
 TextEditingController controllerkode_mk;
 TextEditingController controllernama_mk;
 TextEditingController controllersemester;
 TextEditingController controllersifat;
 TextEditingController controllersks;
 TextEditingController controllerketerangan;

  void _editdata() {
    Firestore.instance.runTransaction((Transaction transaction)async{
      DocumentSnapshot snapshot = 
      await transaction.get(widget.index);
      await transaction.update(snapshot.reference,{
        "kode_bk":_kode_bk,
        "kode_mk":_kode_mk,
        "nama_mk":_nama_mk,
        "semester":_semester,
        "sifat":_sifat,
        "sks":_sks,
        "keterangan":_keterangan,
      });
    });
    Navigator.pop(context);
  }
 

  @override
  void initState(){
    super.initState();
    controllerkode_bk = TextEditingController(text: widget.kode_bk);
    controllerkode_mk = TextEditingController(text: widget.kode_mk);
    controllernama_mk = TextEditingController(text: widget.nama_mk);
    controllersemester = TextEditingController(text: widget.semester);
    controllersifat = TextEditingController(text: widget.sifat);
    controllersks = TextEditingController(text: widget.sks);
    controllerketerangan = TextEditingController(text: widget.keterangan);
    _kode_bk = widget.kode_bk;
    _kode_mk = widget.kode_mk;
    _nama_mk = widget.nama_mk;
    _semester = widget.semester;
    _sifat = widget.sifat;
    _sks = widget.sks;
    _keterangan = widget.keterangan;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Mata kuliah'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           TextField(
             controller: controllerkode_bk,
             onChanged: (String str){
               setState(() {
                 _kode_bk=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.person),
               hintText: "Kode BK"
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
               hintText: "Kode MK"
             ),
           ),
           TextField(
             controller: controllernama_mk,
             onChanged: (String str){
               setState(() {
                 _nama_mk=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.event_note),
               hintText: "Nama MK"
             ),
           ),
           TextField(
             controller: controllersemester,
             onChanged: (String str){
               setState(() {
                 _semester=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.event_note),
               hintText: "Semester"
             ),
           ),
           TextField(
             controller: controllersifat,
             onChanged: (String str){
               setState(() {
                 _sifat=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.event_note),
               hintText: "Sifat"
             ),
           ),
           TextField(
             controller: controllersks,
             onChanged: (String str){
               setState(() {
                 _sks=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.event_note),
               hintText: "SKS"
             ),
           ),
           TextField(
             controller: controllerketerangan,
             onChanged: (String str){
               setState(() {
                 _keterangan=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.event_note),
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