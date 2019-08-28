import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FormEditDataMahasiswaStatus extends StatefulWidget {
  FormEditDataMahasiswaStatus({this.nim,this.status,this.tahun,this.index});
  final String nim;
  final String status;
  final String tahun;
  final index;
  @override
  _FormEditDataMahasiswaStatusState createState() => _FormEditDataMahasiswaStatusState();
}

class _FormEditDataMahasiswaStatusState extends State<FormEditDataMahasiswaStatus> {


 String _nim,_status,_tahun;
 TextEditingController controllernim;
 TextEditingController controllerstatus;
 TextEditingController controllertahun;

  void _editdata() {
    Firestore.instance.runTransaction((Transaction transaction)async{
      DocumentSnapshot snapshot = 
      await transaction.get(widget.index);
      await transaction.update(snapshot.reference,{
        "nim":_nim,
        "status":_status,
      });
    });
    Navigator.pop(context);
  }
 

  @override
  void initState(){
    super.initState();
    controllernim = TextEditingController(text: widget.nim);
    controllerstatus = TextEditingController(text: widget.status);
    controllertahun = TextEditingController(text: widget.tahun);
    _nim = widget.nim;
    _status = widget.status;
    _tahun = widget.tahun;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data MahsiswaStatus'),
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
             controller: controllerstatus,
             onChanged: (String str){
               setState(() {
                 _status=str;
               });
             },
             
             decoration: InputDecoration(
               icon: Icon(Icons.format_list_numbered_rtl),
               hintText: "Status"
             ),
           ),
           TextField(
             controller: controllertahun,
             onChanged: (String str){
               setState(() {
                 _tahun=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.event_note),
               hintText: "Tahun"
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