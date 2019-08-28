import 'package:data_monitoring_mahasiswa/Form/FormEditDataPengampu.dart';
import 'package:data_monitoring_mahasiswa/Form/FormTambahDataPengampu.dart';
import 'package:data_monitoring_mahasiswa/model/Pengampu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DataPengampu extends StatefulWidget {
  @override
  _DataPengampuState createState() => _DataPengampuState();
}

class _DataPengampuState extends State<DataPengampu> {
  
@override
  void initState() {
    super.initState();
    getUID();
    
  }  


String _dataku;

 void _adddata() {
    Navigator.of(context).push(
    MaterialPageRoute(builder: (c) => FormTambahDataPengampu())
  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Pengampu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           StreamBuilder(
             stream: Pengampu().getDataPengampu(),

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
                      String kelas = document[i].data["kelas"].toString();
                      String kode_mk = document[i].data["kode_mk"].toString();
                      String thn_ajar = document[i].data["thn_ajar"].toString();
                   
                      


                      return ExpansionTile(
                        title: Text(id_dosen),
                        children: <Widget>[
                          ListTile(
                            leading: Text("kelas :"),
                          title: Text(kelas),
                        ),
                          ListTile(
                            leading: Text("kode_mk:"),
                          title: Text(kode_mk),
                        ),
                          ListTile(
                            leading: Text("thn_ajar:"),
                          title: Text(thn_ajar),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context)=> FormEditDataPengampu(
                                  id_dosen: document[i].data['id_dosen'],
                                  kelas: document[i].data['kelas'],
                                  kode_mk: document[i].data['kode_mk'],
                                  thn_ajar: document[i].data['thn_ajar'],
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