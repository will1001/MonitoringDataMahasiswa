import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FormEditDataUsers extends StatefulWidget {
  FormEditDataUsers({this.email,this.roles,this.username,this.index});
  final String email;
  final String roles;
  final String username;
  final index;
  @override
  _FormEditDataUsersState createState() => _FormEditDataUsersState();
}

class _FormEditDataUsersState extends State<FormEditDataUsers> {


 String _email,_roles,_username;
 TextEditingController controlleremail;
 TextEditingController controllerroles;
 TextEditingController controllerusername;

  void _editdata() {
    Firestore.instance.runTransaction((Transaction transaction)async{
      DocumentSnapshot snapshot = 
      await transaction.get(widget.index);
      await transaction.update(snapshot.reference,{
        "email":_email,
        "roles":_roles,
        "username":_username,
      });
    });
    Navigator.pop(context);
  }
 

  @override
  void initState(){
    super.initState();
    controlleremail = TextEditingController(text: widget.email);
    controllerroles = TextEditingController(text: widget.roles);
    controllerusername = TextEditingController(text: widget.username);
    _email = widget.email;
    _roles = widget.roles;
    _username = widget.username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Users'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           TextField(
             controller: controlleremail,
             onChanged: (String str){
               setState(() {
                 _email=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.person),
               hintText: "Email"
             ),
           ),
           TextField(
             controller: controllerroles,
             onChanged: (String str){
               setState(() {
                 _roles=str;
               });
             },
             
             decoration: InputDecoration(
               icon: Icon(Icons.format_list_numbered_rtl),
               hintText: "Status"
             ),
           ),
           TextField(
             controller: controllerusername,
             onChanged: (String str){
               setState(() {
                 _username=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.event_note),
               hintText: "Username"
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