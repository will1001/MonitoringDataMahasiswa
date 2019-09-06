import 'package:data_monitoring_mahasiswa/Form/FormEditDataUsers.dart';
import 'package:data_monitoring_mahasiswa/Form/FormTambahDataUsers.dart';
import 'package:data_monitoring_mahasiswa/model/JalurMasuk.dart';
import 'package:data_monitoring_mahasiswa/model/Users.dart';
import 'package:data_monitoring_mahasiswa/model/Mahasiswa.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DataUsers extends StatefulWidget {
  @override
  _DataUsersState createState() => _DataUsersState();
}

class _DataUsersState extends State<DataUsers> {
  String onchange;

  
@override
  void initState() {
    super.initState();
    getUID();
    
  }  

String _email,_roles,_username;

String _dataku;

 void _adddata() {
    Navigator.of(context).push(
    MaterialPageRoute(builder: (c) => FormTambahDataUsers())
  );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Users'),
        actions: <Widget>[
          IconButton(
          icon: Icon(Icons.menu),
          onPressed: (){
            
          },
        ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           StreamBuilder(
             stream: Users().getDataUsers(),

             builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
               if(!snapshot.hasData)
               return new Container(child: Center(
                 child: CircularProgressIndicator(),
               ),);

               return new TampilData(document: snapshot.data.documents,);
             },
           ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adddata,
        tooltip: 'Adddata',
        child: Icon(Icons.add),
      ), 
    );
  }
  getUID() async {
    
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user = await _auth.currentUser();
  String uid = user.uid;
  _dataku = uid;
   return  uid;
  }

}


class TampilData extends StatelessWidget {
  TampilData({this.document});
  final List<DocumentSnapshot> document;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: SizedBox(
            height: 500.0,
            width: 500.0,
            child: ListView.builder(
                    itemCount: document.length,
                    itemBuilder: (BuildContext context, int i){
                      String email = document[i].data["email"].toString();
                      String roles = document[i].data["roles"].toString();
                      String username = document[i].data["username"].toString();
                      


                      return ExpansionTile(
                        title: Text(username),
                        children: <Widget>[
                          ListTile(
                            leading: Text("Status:"),
                          title: Text(roles),
                        ),
                        ListTile(
                            leading: Text("email :"),
                          title: Text(email),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context)=> FormEditDataUsers(
                                  email: document[i].data['email'],
                                  roles: document[i].data['roles'],
                                  username: document[i].data['username'],
                                  index:document[i].reference,
                                )
                              ));
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: (){
                              Firestore.instance.runTransaction((Transaction transaction)async{
                                DocumentSnapshot snapshot = 
                                await transaction.get(document[i].reference);
                                await transaction.delete(snapshot.reference);
                              });
                            },
                          )
                          ],
                        )
                        ],
                      );
                    },
                  ),
          ),
        )
      ],
    );
  }
}