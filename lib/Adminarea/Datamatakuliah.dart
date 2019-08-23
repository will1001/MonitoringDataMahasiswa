import 'package:data_monitoring_mahasiswa/Form/FormEditDataMataKuliah.dart';
import 'package:data_monitoring_mahasiswa/Form/FormTambahDataMataKuliah.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Datamatakuliah extends StatefulWidget {
  @override
  _DatamatakuliahState createState() => _DatamatakuliahState();
}

class _DatamatakuliahState extends State<Datamatakuliah> {
  
@override
  void initState() {
    super.initState();
    getUID();
    
  }  


String _dataku;

 void _adddata() {
    Navigator.of(context).push(
    MaterialPageRoute(builder: (c) => FormTambahDataMataKuliah())
  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Mata Kuliah'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           StreamBuilder(
             stream: Firestore.instance
             .collection("matakuliah")
             .snapshots(),

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
                      String kode_bk = document[i].data["kode_bk"].toString();
                      String kode_mk = document[i].data["kode_mk"].toString();
                      String nama_mk = document[i].data["nama_mk"].toString();
                      String semester = document[i].data["semester"].toString();
                      String sifat = document[i].data["sifat"].toString();
                      String sks = document[i].data["sks"].toString();
                      String keterangan = document[i].data["keterangan"].toString();
                   
                      


                      return ExpansionTile(
                        title: Text(nama_mk),
                        children: <Widget>[
                          ListTile(
                            leading: Text("kode_bk :"),
                          title: Text(kode_bk),
                        ),
                          ListTile(
                            leading: Text("kode_mk:"),
                          title: Text(kode_mk),
                        ),
                          ListTile(
                            leading: Text("semester:"),
                          title: Text(semester),
                        ),
                          ListTile(
                            leading: Text("sifat:"),
                          title: Text(sifat),
                        ),
                          ListTile(
                            leading: Text("sks:"),
                          title: Text(sks),
                        ),
                          ListTile(
                            leading: Text("keterangan:"),
                          title: Text(keterangan),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context)=> FormEditDataMataKuliah(
                                  kode_bk: document[i].data['kode_bk'],
                                  kode_mk: document[i].data['kode_mk'],
                                  nama_mk: document[i].data['nama_mk'],
                                  semester: document[i].data['semester'],
                                  sifat: document[i].data['sifat'],
                                  sks: document[i].data['sks'],
                                  keterangan: document[i].data['keterangan'],
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