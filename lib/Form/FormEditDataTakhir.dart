import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FormEditDataTakhir extends StatefulWidget {
  FormEditDataTakhir({this.nim,this.pmb1,this.pmb2,this.tgl_proposal,this.tgl_shasil,this.tgl_ujian,this.index});
  final String nim;
  final String pmb1;
  final String pmb2;
  final String tgl_proposal;
  final String tgl_shasil;
  final String tgl_ujian;
  final index;
  @override
  _FormEditDataTakhirState createState() => _FormEditDataTakhirState();
}

class _FormEditDataTakhirState extends State<FormEditDataTakhir> {


 String _nim,_pmb1,_pmb2,_tgl_proposal,_tgl_shasil,_tgl_ujian;
 TextEditingController controllernim;
 TextEditingController controllerpmb1;
 TextEditingController controllerpmb2;
 TextEditingController controllertgl_proposal;
 TextEditingController controllertgl_shasil;
 TextEditingController controllertgl_ujian;

  void _editdata() {
    Firestore.instance.runTransaction((Transaction transaction)async{
      DocumentSnapshot snapshot = 
      await transaction.get(widget.index);
      await transaction.update(snapshot.reference,{
        "nim":_nim,
        "pmb1":_pmb1,
        "pmb2":_pmb2,
        "tgl_proposal":_tgl_proposal,
        "tgl_shasil":_tgl_shasil,
        "tgl_ujian":_tgl_ujian,
      });
    });
    Navigator.pop(context);
  }
 

  @override
  void initState(){
    super.initState();
    controllernim = TextEditingController(text: widget.nim);
    controllerpmb1 = TextEditingController(text: widget.pmb1);
    controllerpmb2 = TextEditingController(text: widget.pmb2);
    controllertgl_proposal = TextEditingController(text: widget.tgl_proposal);
    controllertgl_shasil = TextEditingController(text: widget.tgl_shasil);
    controllertgl_ujian = TextEditingController(text: widget.tgl_ujian);
    _nim = widget.nim;
    _pmb1 = widget.pmb1;
    _pmb2 = widget.pmb2;
    _tgl_proposal = widget.tgl_proposal;
    _tgl_shasil = widget.tgl_shasil;
    _tgl_ujian = widget.tgl_ujian;
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
             controller: controllernim,
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
             controller: controllerpmb1,
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
             controller: controllerpmb2,
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
             controller: controllertgl_proposal,
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
             controller: controllertgl_shasil,
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
             controller: controllertgl_ujian,
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
             onPressed: _editdata,
           ),
          ],
        ),
      ),
    );
  }
}