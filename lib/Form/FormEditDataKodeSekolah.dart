import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FormEditDataKodeSekolah extends StatefulWidget {
  FormEditDataKodeSekolah({this.id_sekolah,this.keterangan,this.nama_sekolah,this.index});
  final String id_sekolah;
  final String keterangan;
  final String nama_sekolah;
  final index;
  @override
  _FormEditDataKodeSekolahState createState() => _FormEditDataKodeSekolahState();
}

class _FormEditDataKodeSekolahState extends State<FormEditDataKodeSekolah> {


 String _id_sekolah,_keterangan,_nama_sekolah;
 TextEditingController controllerid_sekolah;
 TextEditingController controllerketerangan;
 TextEditingController controllernama_sekolah;

  void _editdata() {
    Firestore.instance.runTransaction((Transaction transaction)async{
      DocumentSnapshot snapshot = 
      await transaction.get(widget.index);
      await transaction.update(snapshot.reference,{
        "id_sekolah":_id_sekolah,
        "keterangan":_keterangan,
        "nama_sekolah":_nama_sekolah,
      });
    });
    Navigator.pop(context);
  }
 

  @override
  void initState(){
    super.initState();
    controllerid_sekolah = TextEditingController(text: widget.id_sekolah);
    controllerketerangan = TextEditingController(text: widget.keterangan);
    controllernama_sekolah = TextEditingController(text: widget.nama_sekolah);
    _id_sekolah = widget.id_sekolah;
    _keterangan = widget.keterangan;
    _nama_sekolah = widget.nama_sekolah;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Kode Sekolah'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           TextField(
             controller: controllerid_sekolah,
             onChanged: (String str){
               setState(() {
                 _id_sekolah=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.person),
               hintText: "Id Sekolah"
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
               icon: Icon(Icons.format_list_numbered_rtl),
               hintText: "Keterangan"
             ),
           ),
           TextField(
             controller: controllernama_sekolah,
             onChanged: (String str){
               setState(() {
                 _nama_sekolah=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.event_note),
               hintText: "Nama Sekolah"
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