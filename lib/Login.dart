import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Adminarea/AdminPage.dart';
import 'Dosenarea/Dosenpage.dart';
import 'Mahasiswaarea/Mahasiswapage.dart';



class Login extends StatefulWidget {
  
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email,_password,_username,_roles;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.home),
        title: Text("Data Monitoring Mahasiswa"),
      ),
      body: Form(
        key: _formkey,
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
           TextFormField(
             validator: (input){
               if(input.isEmpty){
                 return "Mohon isi username";
               }
             },
             onSaved: (input) => _username = input,
             decoration: InputDecoration(
               labelText: 'Username'
             ),
           ),TextFormField(
             validator: (input){
               if(input.isEmpty){
                 return "Mohon isi password";
               }
             },
             onSaved: (input) => _password = input,
             obscureText: true,
             decoration: InputDecoration(
               labelText: 'password'
             ),
           ),
           RaisedButton(
             child: Text('Login'),
             color: Colors.red,
             splashColor: Colors.blue,
             onPressed: _otentikasiLogin,
           ),
          ],
        ),
      ),
      ),
    );
  }



  getdata() async{
    
  final formstate = _formkey.currentState;
    if(formstate.validate()){
      
      formstate.save();
      try{
      final documents = await Firestore.instance.collection('users').where("username", isEqualTo: _username).getDocuments();
     final userObject = documents.documents.first.data;
     return userObject;
      }catch(e){
        print(e.message);
      }
    }
  }
  

  void _otentikasiLogin() async {
    final formstate = _formkey.currentState;
    if(formstate.validate()){
      
      formstate.save();
      try{
        final data = await getdata();
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: data["email"] ,password: _password);
      print(data["roles"]);
      if(data["roles"] == "admin"){
        Navigator.of(context).push(
        MaterialPageRoute(builder: (c) => Adminpage())
        );
      }
      if(data["roles"] == "dosen"){
        Navigator.of(context).push(
        MaterialPageRoute(builder: (c) => Dosenpage())
        );
      }
      if(data["roles"] == "mahasiswa"){
        Navigator.of(context).push(
        MaterialPageRoute(builder: (c) => Mahasiswapage())
        );
      }

      
      }catch(e){
        print(e.message);
      }
    }
  }
}