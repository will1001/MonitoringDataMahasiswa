import 'package:data_monitoring_mahasiswa/Form/FormEditDataMahasiswa.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Dosenpage extends StatefulWidget {
  @override
  _DosenpageState createState() => _DosenpageState();
}

class _DosenpageState extends State<Dosenpage> {
  
@override
  void initState() {
    super.initState();
    getUID();
    
  }  

String _nama,_nim;

String _dataku;

  void _adddata() {
    Firestore.instance.runTransaction((Transaction transsaction) async {
      CollectionReference reference = Firestore.instance.collection('task');
      await reference.add({
        "nama" : _nama,
        "nim"  : _nim,
      });
    });
  }
  
  void _adddata2() {
    Firestore.instance.collection('users').document('menWqsBeKuaqlszEPMPStCtSVxM2')
  .setData({ 'username': 'mahasiswa', 'roles': 'mahasiswa' });
  }

  void _editdata() {
    print(Firestore.instance.collection('task').snapshots());
  }
  void _deletedata() {
    print(Firestore.instance.collection('task').snapshots());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('dosen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           TextField(
             onChanged: (String str){
               setState(() {
                 _nama=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.person),
               hintText: "nama"
             ),
           ),
           TextField(
             onChanged: (String str){
               setState(() {
                 _nim=str;
               });
             },
             decoration: InputDecoration(
               icon: Icon(Icons.confirmation_number),
               hintText: "nim"
             ),
           ),
           StreamBuilder<DocumentSnapshot>(
             stream: Firestore.instance
             .collection('users')
             .document(_dataku)
             //.where("nim",isEqualTo: "f1b012007")
             .snapshots(),

             builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot> snapshot){
              //  if(!snapshot.hasData)
              //  return new Container(child: Center(
              //    child: CircularProgressIndicator(),
              //  ),);

              //  return new Tasklist(document: snapshot.data.documents,);
              if(snapshot.hasError){
                return Text('Error:${snapshot.error}');
              }
              switch(snapshot.connectionState){
                case ConnectionState.waiting: return  Text('loading . . .');
                default:
                  return Text(snapshot.data['roles']);
              }
             },
           ),
           Row(
             children: <Widget>[
               IconButton(
             onPressed: _adddata2,
             icon: Icon(Icons.add),
           ),
           IconButton(
             onPressed: _editdata,
             icon: Icon(Icons.edit),
           ),
           IconButton(
             onPressed: _deletedata,
             icon: Icon(Icons.delete),
           ),
             ],
           )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _adddata2,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), 
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


class Tasklist extends StatelessWidget {
  Tasklist({this.document});
  final List<DocumentSnapshot> document;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: SizedBox(
            height: 200.0,
            child: ListView.builder(
                    itemCount: document.length,
                    itemBuilder: (BuildContext context, int i){
                      String nama = document[i].data["nama"].toString();
                      String nim = document[i].data["nim"].toString();
                      


                      return Column(
                        children: <Widget>[
                          Text(nama),
                          Text(nim),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context)=> FormEditDataMahasiswa(
                                  nama: document[i].data['nama'],
                                  nim: document[i].data['nim'],
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
                      );
                    },
                  ),
          ),
        )
      ],
    );
  }
}