import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FormEditDataPengampu extends StatefulWidget {
  FormEditDataPengampu({this.id_dosen,this.kelas,this.kode_mk,this.thn_ajar,this.index});
  final String id_dosen;
  final String kelas;
  final String kode_mk;
  final String thn_ajar;
  final index;
  @override
  _FormEditDataPengampuState createState() => _FormEditDataPengampuState();
}

class _FormEditDataPengampuState extends State<FormEditDataPengampu> {


 String _id_dosen,_kelas,_kode_mk,_thn_ajar;
 TextEditingController controllerid_dosen;
 TextEditingController controllerkelas;
 TextEditingController controllerkode_mk;
 TextEditingController controllerthn_ajar;

  void _editdata() {
    Firestore.instance.runTransaction((Transaction transaction)async{
      DocumentSnapshot snapshot = 
      await transaction.get(widget.index);
      await transaction.update(snapshot.reference,{
        "id_dosen":_id_dosen,
        "kelas":_kelas,
        "kode_mk":_kode_mk,
        "thn_ajar":_thn_ajar,
      });
    });
    Navigator.pop(context);
  }
 

  @override
  void initState(){
    super.initState();
    controllerid_dosen = TextEditingController(text: widget.id_dosen);
    controllerkelas = TextEditingController(text: widget.kelas);
    controllerkode_mk = TextEditingController(text: widget.kode_mk);
    controllerthn_ajar = TextEditingController(text: widget.thn_ajar);
    _id_dosen = widget.id_dosen;
    _kelas = widget.kelas;
    _kode_mk = widget.kode_mk;
    _thn_ajar = widget.thn_ajar;
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
             controller: controllerid_dosen,
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
             controller: controllerkelas,
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
             controller: controllerkode_mk,
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