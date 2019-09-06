import 'package:data_monitoring_mahasiswa/Form/FormEditDataMahasiswa.dart';
import 'package:data_monitoring_mahasiswa/Login.dart';
import 'package:data_monitoring_mahasiswa/Mahasiswaarea/DataNilaiMahasiswaPage.dart';
import 'package:data_monitoring_mahasiswa/Mahasiswaarea/DataSkripsiMahasiswaPage.dart';
import 'package:data_monitoring_mahasiswa/model/Mahasiswa.dart';
import 'package:data_monitoring_mahasiswa/model/Takhir.dart';
import 'package:data_monitoring_mahasiswa/model/Users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Mahasiswapage extends StatefulWidget {
  @override
  _MahasiswapageState createState() => _MahasiswapageState();
}

class _MahasiswapageState extends State<Mahasiswapage> {
  String _nama, _nim;

  String nim;
  var datamhs;

  @override
  void initState() {
    super.initState();
    getUID();
    print('${nim}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Icon(
                Icons.account_circle,
                size: 120.0,
                color: Colors.grey[200],
              ),
              decoration: BoxDecoration(
                color: Colors.red,
              ),
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.format_list_numbered),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (c) => DataNilaiMahasiswapage()));
                    },
                    child: Text('      Nilai'),
                  )
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.book),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (c) => DataSkripsiMahasiswapage()));
                    },
                    child: Text('      Skripsi'),
                  )
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.lock_open),
                  GestureDetector(
                    onTap: () async{
                      // await FirebaseAuth.instance.signOut();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (c) => Login()));
                    },
                    child: Text('      Logout'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Mahasiswa'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Icon(
                Icons.account_circle,
                size: 150.0,
                color: Colors.grey,
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            StreamBuilder(
              stream: Mahasiswa().getDataMahasiswaWhereNIM(nim),
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
    );
  }

  getUID() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    await Firestore.instance
        .collection('users')
        .document('${user.uid}')
        .get()
        .then((DocumentSnapshot ds) {
      setState(() {
        nim = ds.data['username'];
      });
    });
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
            height: 400.0,
            child: ListView.builder(
              itemCount: document.length,
              itemBuilder: (BuildContext context, int i) {
                String nama = document[i].data["nama"].toString();
                String nim = document[i].data["nim"].toString();
                String thn_masuk = document[i].data["thn_masuk"].toString();

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left:39.0 ,bottom:18.0 ),
                        child: Row(
                          children: <Widget>[
                            Text('Nama'),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 38.0, right: 5.0),
                              child: Text(':'),
                            ),
                            Text(nama),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:39.0 ,bottom:18.0 ),
                        child: Row(
                          children: <Widget>[
                            Text('NIM'),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 50.0, right: 5.0),
                              child: Text(':'),
                            ),
                            Text(nim),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:39.0 ,bottom:18.0 ),
                        child: Row(
                          children: <Widget>[
                            Text('Angkatan'),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 18.0, right: 5.0),
                              child: Text(':'),
                            ),
                            Text(thn_masuk),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:39.0 ,bottom:18.0 ),
                        child: Row(
                          children: <Widget>[
                            Text('IPK'),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 56.0, right: 5.0),
                              child: Text(':'),
                            ),
                            Text(''),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:39.0 ,bottom:18.0 ),
                        child: Row(
                          children: <Widget>[
                            Text('Jumlah SKS'),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 3.0, right: 5.0),
                              child: Text(':'),
                            ),
                            Text(''),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
