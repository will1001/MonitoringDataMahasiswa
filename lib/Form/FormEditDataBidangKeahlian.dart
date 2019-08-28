import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FormEditDataBidangKeahlian extends StatefulWidget {
  FormEditDataBidangKeahlian({this.keterangan,this.kode_bk,this.nama_bk,this.index});
  final String keterangan;
  final String kode_bk;
  final String nama_bk;
  final index;
  @override
  _FormEditDataBidangKeahlianState createState() => _FormEditDataBidangKeahlianState();
}

class _FormEditDataBidangKeahlianState extends State<FormEditDataBidangKeahlian> {


 String _keterangan,_kode_bk,_nama_bk;
 TextEditingController controllerketerangan;
 TextEditingController controllerkode_bk;
 TextEditingController controllernama_bk;

  void _editdata() {
    Firestore.instance.runTransaction((Transaction transaction)async{
      DocumentSnapshot snapshot = 
      await transaction.get(widget.index);
      await transaction.update(snapshot.reference,{
        "keterangan":_keterangan,
        "kode_bk":_kode_bk,
        "nama_bk":_nama_bk,
      });
    });
    Navigator.pop(context);
  }
 

  @override
  void initState(){
    super.initState();
    controllerketerangan = TextEditingController(text: widget.keterangan);
    controllerkode_bk = TextEditingController(text: widget.kode_bk);
    controllernama_bk = TextEditingController(text: widget.nama_bk);
    _keterangan = widget.keterangan;
    _kode_bk = widget.kode_bk;
    _nama_bk = widget.nama_bk;
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
             controller: controllerketerangan,
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
             controller: controllerkode_bk,
             onChanged: (String str){
               setState(() {
                 _kode_bk=str;
               });
             },
             
             decoration: InputDecoration(
               icon: Icon(Icons.format_list_numbered_rtl),
               hintText: "Kode BK"
             ),
           ),
           TextField(
             controller: controllernama_bk,
             onChanged: (String str){
               setState(() {
                 _nama_bk=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.event_note),
               hintText: "Nama BK"
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