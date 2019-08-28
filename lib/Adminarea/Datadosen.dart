import 'package:data_monitoring_mahasiswa/Form/FormEditDataDosen.dart';
import 'package:data_monitoring_mahasiswa/Form/FormTambahDataDosen.dart';
import 'package:data_monitoring_mahasiswa/model/Dosen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Datadosen extends StatefulWidget {
  @override
  _DatadosenState createState() => _DatadosenState();
}

class _DatadosenState extends State<Datadosen> {
  
@override
  void initState() {
    super.initState();
    getUID();
    
  }  


String _dataku;

 void _adddata() {
    Navigator.of(context).push(
    MaterialPageRoute(builder: (c) => FormTambahDataDosen())
  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Dosen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           StreamBuilder(
             stream: Dosen().getDataDosen(),

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
                      String id_dosen = document[i].data["id_dosen"].toString();
                      String nama_dosen = document[i].data["nama_dosen"].toString();
                      String nip = document[i].data["nip"].toString();
                   
                      


                      return ExpansionTile(
                        title: Text(nama_dosen),
                        children: <Widget>[
                          ListTile(
                            leading: Text("id_dosen :"),
                          title: Text(id_dosen),
                        ),
                          ListTile(
                            leading: Text("nip:"),
                          title: Text(nip),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context)=> FormEditDataDosen(
                                  id_dosen: document[i].data['id_dosen'],
                                  nama_dosen: document[i].data['nama_dosen'],
                                  nip: document[i].data['nip'],
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