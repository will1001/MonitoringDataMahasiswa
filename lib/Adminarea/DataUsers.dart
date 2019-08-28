import 'package:data_monitoring_mahasiswa/Form/FormEditDataNilai.dart';
import 'package:data_monitoring_mahasiswa/Form/FormTambahDataNilai.dart';
import 'package:data_monitoring_mahasiswa/model/JalurMasuk.dart';
import 'package:data_monitoring_mahasiswa/model/Nilai.dart';
import 'package:data_monitoring_mahasiswa/model/Mahasiswa.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DataNilai extends StatefulWidget {
  @override
  _DataNilaiState createState() => _DataNilaiState();
}

class _DataNilaiState extends State<DataNilai> {
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
    MaterialPageRoute(builder: (c) => FormTambahDataNilai())
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
             stream: Nilai().getdatanilai(),

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
                      String kelas = document[i].data["kelas"].toString();
                      String kode_mk = document[i].data["kode_mk"].toString();
                      String nilai = document[i].data["nilai"].toString();
                      String nim = document[i].data["nim"].toString();
                      String thn_ajar = document[i].data["thn_ajar"].toString();
                      


                      return ExpansionTile(
                        title: Text(nim),
                        children: <Widget>[
                          ListTile(
                            leading: Text("Kode MK:"),
                          title: Text(kode_mk),
                        ),
                        ListTile(
                            leading: Text("Niali :"),
                          title: Text(nilai),
                        ),
                        ListTile(
                            leading: Text("Tahun Ajar :"),
                          title: Text(thn_ajar),
                        ),
                        ListTile(
                            leading: Text("Kelas :"),
                          title: Text(kelas),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context)=> FormEditDataNilai(
                                  kelas: document[i].data['kelas'],
                                  kode_mk: document[i].data['kode_mk'],
                                  nilai: document[i].data['nilai'],
                                  nim: document[i].data['nim'],
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