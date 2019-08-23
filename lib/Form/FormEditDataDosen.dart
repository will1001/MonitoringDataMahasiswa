import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FormEditDataDosen extends StatefulWidget {
  FormEditDataDosen({this.id_dosen,this.nama_dosen,this.nip,this.index});
  final String id_dosen;
  final String nama_dosen;
  final String nip;
  final index;
  @override
  _FormEditDataDosenState createState() => _FormEditDataDosenState();
}

class _FormEditDataDosenState extends State<FormEditDataDosen> {


 String _id_dosen,_nama_dosen,_nip;
 TextEditingController controllerid_dosen;
 TextEditingController controllernama_dosen;
 TextEditingController controllernip;

  void _editdata() {
    Firestore.instance.runTransaction((Transaction transaction)async{
      DocumentSnapshot snapshot = 
      await transaction.get(widget.index);
      await transaction.update(snapshot.reference,{
        "id_dosen":_id_dosen,
        "nama_dosen":_nama_dosen,
        "nip":_nip,
      });
    });
    Navigator.pop(context);
  }
 

  @override
  void initState(){
    super.initState();
    controllerid_dosen = TextEditingController(text: widget.id_dosen);
    controllernama_dosen = TextEditingController(text: widget.nama_dosen);
    controllernip = TextEditingController(text: widget.nip);
    _id_dosen = widget.id_dosen;
    _nama_dosen = widget.nama_dosen;
    _nip = widget.nip;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Dosen'),
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
             controller: controllernama_dosen,
             onChanged: (String str){
               setState(() {
                 _nama_dosen=str;
               });
             },
             
             decoration: InputDecoration(
               icon: Icon(Icons.format_list_numbered_rtl),
               hintText: "Nama Dosen"
             ),
           ),
           TextField(
             controller: controllernip,
             onChanged: (String str){
               setState(() {
                 _nip=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.event_note),
               hintText: "NIP"
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