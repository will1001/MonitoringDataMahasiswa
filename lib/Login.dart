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
  String _email, _password, _username, _roles;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Opacity(opacity: 0.0, child: Icon(Icons.home)),
        title: Text("Data Monitoring Mahasiswa"),
      ),
      body: Form(
        key: _formkey,
        child: Center(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 55.0),
                child: SizedBox(
                  child: Image.network(
                      'http://2.bp.blogspot.com/-84XHfApuUYc/UinPULOJ3HI/AAAAAAAAPCU/v_BGkom15QA/s1600/LOGO+UNIVERSITAS+MATARAM.png'),
                  height: 150.0,
                  width: 150.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  validator: (input) {
                    if (input.isEmpty) {
                      return "Mohon isi username";
                    }
                  },
                  onSaved: (input) => _username = input,
                  decoration: InputDecoration(labelText: 'Username'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  validator: (input) {
                    if (input.isEmpty) {
                      return "Mohon isi password";
                    }
                  },
                  onSaved: (input) => _password = input,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: 'password',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.remove_red_eye),
                      onPressed: () {
                        if (_obscureText == true) {
                          setState(() {
                            _obscureText = false;
                          });
                        } else {
                          setState(() {
                            _obscureText = true;
                          });
                        }
                      },
                    ),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  RaisedButton(
                    child: Text('Login'),
                    color: Colors.red,
                    splashColor: Colors.blue,
                    onPressed: _otentikasiLogin,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  getdata() async {
    final formstate = _formkey.currentState;
    if (formstate.validate()) {
      formstate.save();
      try {
        final documents = await Firestore.instance
            .collection('users')
            .where("username", isEqualTo: _username)
            .getDocuments();

        final userObject = documents.documents.first.data;

        if (documents == null) {
          return null;
        } else {
          return userObject;
        }
      } catch (e) {
        print(e.message);
      }
    }
  }

  void _otentikasiLogin() async {
    final formstate = _formkey.currentState;
    if (formstate.validate()) {
      formstate.save();
      try {
        final data = await getdata();
        if (data == null) {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: 'datakosong@gmail.com', password: _password);
        } else {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: data["email"], password: _password);
        }
        final FirebaseAuth _auth = FirebaseAuth.instance;
        FirebaseUser user = await _auth.currentUser();
        String uid = user.uid;
        if (data["roles"] == "Admin") {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (c) => Adminpage()));
        }
        if (data["roles"] == "Dosen") {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (c) => Dosenpage()));
        }
        if (data["roles"] == "Mahasiswa") {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (c) => Mahasiswapage()));
        }
      } catch (e) {
        print(e.message);
        if (e.message ==
            'There is no user record corresponding to this identifier. The user may have been deleted.') {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Username Salah'),
                  content:
                      Text('Maaf Username Anda Tidak Terdaftar Pada Database'),
                );
              });
        }

        if (e.message =='The password is invalid or the user does not have a password.') {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Password Salah'),
                  content:
                      Text('Cek Kembali password Anda'),
                );
              });
        }
      }
    }
  }
}
