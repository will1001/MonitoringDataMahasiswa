import 'package:data_monitoring_mahasiswa/Form/FormEditDataKodeNilai.dart';
import 'package:data_monitoring_mahasiswa/Form/FormTambahDataKodeNilai.dart';
import 'package:data_monitoring_mahasiswa/model/Dosen.dart';
import 'package:data_monitoring_mahasiswa/model/KodeNilai.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DataKodeNilai extends StatefulWidget {
  @override
  _DataKodeNilaiState createState() => _DataKodeNilaiState();
}

class _DataKodeNilaiState extends State<DataKodeNilai> {
  
@override
  void initState() {
    super.initState();
    getUID();
    
  }  


String _dataku;

 void _adddata() {
    Navigator.of(context).push(
    MaterialPageRoute(builder: (c) => FormTambahDataKodeNilai())
  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Kode Nilai'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           StreamBuilder(
             stream: KodeNilai().getDataKodeNilai(),

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
                      String angka = document[i].data["angka"].toString();
                      String huruf = document[i].data["huruf"].toString();
                      String keterangan = document[i].data["keterangan"].toString();
                   
                      


                      return ExpansionTile(
                        title: Text(huruf),
                        children: <Widget>[
                          ListTile(
                            leading: Text("Angka :"),
                          title: Text(angka),
                        ),
                          ListTile(
                            leading: Text("Keterangan:"),
                          title: Text(keterangan),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context)=> FormEditDataKodeNilai(
                                  angka: document[i].data['angka'],
                                  huruf: document[i].data['huruf'],
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