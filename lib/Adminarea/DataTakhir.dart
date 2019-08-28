import 'package:data_monitoring_mahasiswa/Form/FormEditDataTakhir.dart';
import 'package:data_monitoring_mahasiswa/Form/FormTambahDataTakhir.dart';
import 'package:data_monitoring_mahasiswa/model/Takhir.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DataTakhir extends StatefulWidget {
  @override
  _DataTakhirState createState() => _DataTakhirState();
}

class _DataTakhirState extends State<DataTakhir> {
  
@override
  void initState() {
    super.initState();
    getUID();
    
  }  


String _dataku;

 void _adddata() {
    Navigator.of(context).push(
    MaterialPageRoute(builder: (c) => FormTambahDataTakhir())
  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Takhir'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           StreamBuilder(
             stream: Takhir().getDataTakhir(),

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
                      String nim = document[i].data["nim"].toString();
                      String pmb1 = document[i].data["pmb1"].toString();
                      String pmb2 = document[i].data["pmb2"].toString();
                      String tgl_proposal = document[i].data["tgl_proposal"].toString();
                      String tgl_shasil = document[i].data["tgl_shasil"].toString();
                      String tgl_ujian = document[i].data["tgl_ujian"].toString();
                   
                      


                      return ExpansionTile(
                        title: Text(nim),
                        children: <Widget>[
                          ListTile(
                            leading: Text("Pembimbing 1:"),
                          title: Text(pmb1),
                        ),
                          ListTile(
                            leading: Text("Pembimbing 2:"),
                          title: Text(pmb2),
                        ),
                          ListTile(
                            leading: Text("Tanggal Proposal:"),
                          title: Text(tgl_proposal),
                        ),
                          ListTile(
                            leading: Text("Tanggal Hasil:"),
                          title: Text(tgl_shasil),
                        ),
                          ListTile(
                            leading: Text("Tanggal Ujian:"),
                          title: Text(tgl_ujian),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context)=> FormEditDataTakhir(
                                  nim: document[i].data['nim'],
                                  pmb1: document[i].data['pmb1'],
                                  pmb2: document[i].data['pmb2'],
                                  tgl_proposal: document[i].data['tgl_proposal'],
                                  tgl_shasil: document[i].data['tgl_shasil'],
                                  tgl_ujian: document[i].data['tgl_ujian'],
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