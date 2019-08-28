import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FormEditDataKodeNilai extends StatefulWidget {
  FormEditDataKodeNilai({this.angka,this.huruf,this.keterangan,this.index});
  final String angka;
  final String huruf;
  final String keterangan;
  final index;
  @override
  _FormEditDataKodeNilaiState createState() => _FormEditDataKodeNilaiState();
}

class _FormEditDataKodeNilaiState extends State<FormEditDataKodeNilai> {


 String _angka,_huruf,_keterangan;
 TextEditingController controllerangka;
 TextEditingController controllerhuruf;
 TextEditingController controllerketerangan;

  void _editdata() {
    Firestore.instance.runTransaction((Transaction transaction)async{
      DocumentSnapshot snapshot = 
      await transaction.get(widget.index);
      await transaction.update(snapshot.reference,{
        "angka":_angka,
        "huruf":_huruf,
        "keterangan":_keterangan,
      });
    });
    Navigator.pop(context);
  }
 

  @override
  void initState(){
    super.initState();
    controllerangka = TextEditingController(text: widget.angka);
    controllerhuruf = TextEditingController(text: widget.huruf);
    controllerketerangan = TextEditingController(text: widget.keterangan);
    _angka = widget.angka;
    _huruf = widget.huruf;
    _keterangan = widget.keterangan;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Kode Nilai'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           TextField(
             controller: controllerangka,
             onChanged: (String str){
               setState(() {
                 _angka=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.person),
               hintText: "Angka"
             ),
           ),
           TextField(
             controller: controllerhuruf,
             onChanged: (String str){
               setState(() {
                 _huruf=str;
               });
             },
             
             decoration: InputDecoration(
               icon: Icon(Icons.format_list_numbered_rtl),
               hintText: "Huruf"
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