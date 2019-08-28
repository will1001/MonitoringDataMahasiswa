import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FormEditDataYudisium extends StatefulWidget {
  FormEditDataYudisium({this.nim,this.tgl_ydsm,this.index});
  final String nim;
  final String tgl_ydsm;
  final index;
  @override
  _FormEditDataYudisiumState createState() => _FormEditDataYudisiumState();
}

class _FormEditDataYudisiumState extends State<FormEditDataYudisium> {


 String _nim,_tgl_ydsm;
 TextEditingController controllernim;
 TextEditingController controllertgl_ydsm;

  void _editdata() {
    Firestore.instance.runTransaction((Transaction transaction)async{
      DocumentSnapshot snapshot = 
      await transaction.get(widget.index);
      await transaction.update(snapshot.reference,{
        "nim":_nim,
        "tgl_ydsm":_tgl_ydsm,
      });
    });
    Navigator.pop(context);
  }
 

  @override
  void initState(){
    super.initState();
    controllernim = TextEditingController(text: widget.nim);
    controllertgl_ydsm = TextEditingController(text: widget.tgl_ydsm);
    _nim = widget.nim;
    _tgl_ydsm = widget.tgl_ydsm;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Yudisium'),
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
             controller: controllertgl_ydsm,
             onChanged: (String str){
               setState(() {
                 _tgl_ydsm=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.format_list_numbered_rtl),
               hintText: "Tanggal Yudisium"
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