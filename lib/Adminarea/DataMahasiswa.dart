import 'package:data_monitoring_mahasiswa/Form/FormEditDataMahasiswa.dart';
import 'package:data_monitoring_mahasiswa/Form/FormTambahDataMahasiswa.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DataMahasiswa extends StatefulWidget {
  @override
  _DataMahasiswaState createState() => _DataMahasiswaState();
}

class _DataMahasiswaState extends State<DataMahasiswa> {
  String onchange = "oke";

  
@override
  void initState() {
    super.initState();
    getUID();
    
  }  

String _nama,_nim,_thn_masuk,_ket;

String _dataku;

 void _adddata() {
    Navigator.of(context).push(
    MaterialPageRoute(builder: (c) => FormTambahDataMahasiswa())
  );
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
        title: Text('Data Mahasiswa'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (text) {
                setState(() {
                  onchange = text;
                });
              },
            ),
            Text('$onchange'),
           StreamBuilder(
             stream: Firestore.instance
             .collection("mahasiswa")
            //  .where("nama",isEqualTo: '$onchange').o
            .orderBy("$onchange")
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
                      String nama = document[i].data["nama"].toString();
                      String nim = document[i].data["nim"].toString();
                      String thn_masuk = document[i].data["thn_masuk"].toString();
                      String ket = document[i].data["ket"].toString();
                      


                      return ExpansionTile(
                        title: Text(nama),
                        children: <Widget>[
                          ListTile(
                            leading: Text("NIM :"),
                          title: Text(nim),
                        ),
                          ListTile(
                            leading: Text("Tahun Masuk:"),
                          title: Text(thn_masuk),
                        ),
                          ListTile(
                            leading: Text("Ket :"),
                          title: Text(ket),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context)=> FormEditDataMahasiswa(
                                  nama: document[i].data['nama'],
                                  nim: document[i].data['nim'],
                                  thn_masuk: document[i].data['thn_masuk'],
                                  ket: document[i].data['ket'],
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