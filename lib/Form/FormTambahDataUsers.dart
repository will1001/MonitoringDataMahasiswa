import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FormTambahDataUsers extends StatefulWidget {
  FormTambahDataUsers({this.email, this.roles, this.username, this.index});
  final String email;
  final String roles;
  final String username;
  final index;
  @override
  _FormTambahDataUsersState createState() => _FormTambahDataUsersState();
}

class _FormTambahDataUsersState extends State<FormTambahDataUsers> {
  String _email, _roles, _username, _password;
  String dropdownValue,_nim_nip;

  @override
  void initState() {
    super.initState();
    dropdownValue = 'Dosen';
    _roles = 'Dosen';
    _nim_nip = 'NIP';
  }

  void _adddata() async {
    
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    Firestore.instance.runTransaction((Transaction transsaction) async {
      CollectionReference reference = Firestore.instance.collection('users');
      await reference.document('${user.uid}').setData({
        "email": _email,
        "roles": _roles,
        "username": _username.toUpperCase(),
        "password": _password,
      });
    });
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
              onChanged: (String str) {
                setState(() {
                  _email = str;
                });
              },
              decoration:
                  InputDecoration(icon: Icon(Icons.person), hintText: "Email"),
            ),
            Row(
              children: <Widget>[
                IconTheme(
                  data: IconThemeData(
                  color: Colors.grey
                ),
                child: Icon(Icons.people),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: DropdownButton<String>(
                  value: dropdownValue,
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                      _roles = newValue;
                      if(newValue=='Dosen'){
                        _nim_nip= 'NIP';
                      }else{
                        _nim_nip = 'NIM';
                      }
                    });
                  },
                  items: <String>['Dosen', 'Mahasiswa']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                ),
              ],
            ),
            TextField(
              onChanged: (String str) {
                setState(() {
                  _username = str.toUpperCase();
                });
              },
              decoration: InputDecoration(
                  icon: Icon(Icons.event_note), hintText: _nim_nip),
            ),
            TextField(
              onChanged: (String str) {
                setState(() {
                  _password = str;
                });
              },
              decoration: InputDecoration(
                  icon: Icon(Icons.event_note), hintText: "Password"),
            ),
            RaisedButton(
              child: Text('Submit'),
              color: Colors.red,
              splashColor: Colors.blue,
              onPressed: _adddata,
            ),
          ],
        ),
      ),
    );
  }
}
