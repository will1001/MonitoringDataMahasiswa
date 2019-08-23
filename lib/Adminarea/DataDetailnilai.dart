import 'package:data_monitoring_mahasiswa/Form/FormEditDataNilai.dart';
import 'package:data_monitoring_mahasiswa/Form/FormTambahDataNilai.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataDetailnilai extends StatefulWidget {
  DataDetailnilai({this.kode_mk, this.index});
  final String kode_mk;
  final index;
  @override
  _DataDetailnilaiState createState() => _DataDetailnilaiState();
}

class _DataDetailnilaiState extends State<DataDetailnilai> {
  @override
  void initState() {
    super.initState();
    getUID();
  }

  String _nama, _nim, _thn_masuk, _ket;

  String _dataku;

  void _adddata() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (c) => FormTambahDataNilai()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Nilai'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
              stream: Firestore.instance
                  .collection("nilai")
                  .where("kode_mk", isEqualTo: widget.kode_mk)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return new Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );

                return new TampilData(
                  document: snapshot.data.documents,
                );
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
    return uid;
  }
}

class TampilData extends StatelessWidget {
  TampilData({this.document, this.nilai});
  final String nilai;
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
              itemBuilder: (BuildContext context, int i) {
                String nim = document[i].data["nim"].toString();
                String nilai = document[i].data["nilai"].toString();

                return StreamBuilder(
                    stream: Firestore.instance
                        .collection("mahasiswa")
                        .where("nim", isEqualTo: nim)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData)
                        return new Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      List<DocumentSnapshot> mhs = snapshot.data.documents;
                      return ExpansionTile(
                        title: Text(mhs[0].data["nama"].toString()),
                        children: <Widget>[
                          ListTile(
                            leading: Text("nilai"),
                            title: Text(nilai),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          FormEditDataNilai(
                                            nama: document[i].data['nama'],
                                            nim: document[i].data['nim'],
                                            index: document[i].reference,
                                          )));
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  Firestore.instance.runTransaction(
                                      (Transaction transaction) async {
                                    DocumentSnapshot snapshot =
                                        await transaction
                                            .get(document[i].reference);
                                    await transaction
                                        .delete(snapshot.reference);
                                  });
                                },
                              )
                            ],
                          )
                        ],
                      );
                    });
              },
            ),
          ),
        )
      ],
    );
  }
}
