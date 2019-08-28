import 'package:data_monitoring_mahasiswa/Form/FormEditDataKodeSekolah.dart';
import 'package:data_monitoring_mahasiswa/Form/FormTambahDataKodeSekolah.dart';
import 'package:data_monitoring_mahasiswa/model/JalurMasuk.dart';
import 'package:data_monitoring_mahasiswa/model/KodeSekolah.dart';
import 'package:data_monitoring_mahasiswa/model/Mahasiswa.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DataKodeSekolah extends StatefulWidget {
  @override
  _DataKodeSekolahState createState() => _DataKodeSekolahState();
}

class _DataKodeSekolahState extends State<DataKodeSekolah> {
  String onchange;

  
@override
  void initState() {
    super.initState();
    getUID();
    
  }  

String _id_sekolah,_keterangan,_nama_sekolah;

String _dataku;

 void _adddata() {
    Navigator.of(context).push(
    MaterialPageRoute(builder: (c) => FormTambahDataKodeSekolah())
  );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Kode Sekolah'),
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
             stream: KodeSekolah().getDataKodeSekolah(),

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
                      String id_sekolah = document[i].data["id_sekolah"].toString();
                      String keterangan = document[i].data["keterangan"].toString();
                      String nama_sekolah = document[i].data["nama_sekolah"].toString();
                      


                      return ExpansionTile(
                        title: Text(nama_sekolah),
                        children: <Widget>[
                          ListTile(
                            leading: Text("ID Sekolah:"),
                          title: Text(id_sekolah),
                        ),
                        ListTile(
                            leading: Text("Keterangan :"),
                          title: Text(keterangan),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context)=> FormEditDataKodeSekolah(
                                  id_sekolah: document[i].data['id_sekolah'],
                                  keterangan: document[i].data['keterangan'],
                                  nama_sekolah: document[i].data['nama_sekolah'],
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