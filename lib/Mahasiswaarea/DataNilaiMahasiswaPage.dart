import 'package:data_monitoring_mahasiswa/Form/FormEditDataMahasiswa.dart';
import 'package:data_monitoring_mahasiswa/model/Mahasiswa.dart';
import 'package:data_monitoring_mahasiswa/model/MataKuliah.dart';
import 'package:data_monitoring_mahasiswa/model/Nilai.dart';
import 'package:data_monitoring_mahasiswa/model/Takhir.dart';
import 'package:data_monitoring_mahasiswa/model/Users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DataNilaiMahasiswapage extends StatefulWidget {
  @override
  _DataNilaiMahasiswapageState createState() => _DataNilaiMahasiswapageState();
}

class _DataNilaiMahasiswapageState extends State<DataNilaiMahasiswapage> {
  String _nama, _nim;

  String nim;

  @override
  void initState() {
    super.initState();
    getUID();
    print(nim);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Nilai'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            StreamBuilder(
              stream: Nilai().getDataNilaiWhereNIM(nim),
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
            height: 500.0,
            width: 500.0,
            child: ListView.builder(
              itemCount: document.length,
              itemBuilder: (BuildContext context, int i) {
                String kode_mk = document[i].data["kode_mk"].toString();
                String nilai = document[i].data["nilai"].toString();

                return StreamBuilder(
                  stream: MataKuliah().getDataMataKuliahWhereKodeMk(kode_mk),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData)
                      return new Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    final List<DocumentSnapshot> matkul =
                        snapshot.data.documents;
                    String nama_mk = matkul[0].data["nama_mk"].toString();
                    String semester = matkul[0].data["semester"].toString();
                    String sifat = matkul[0].data["sifat"].toString();
                    String sks = matkul[0].data["sks"].toString();
                    return new ExpansionTile(
                      title: Text(nama_mk),
                      children: <Widget>[
                        ListTile(
                          leading: Text("Nilai :"),
                          title: Text(nilai),
                        ),
                        ListTile(
                          leading: Text("Semester :"),
                          title: Text(semester),
                        ),
                        ListTile(
                          leading: Text("Sifat :"),
                          title: Text(sifat),
                        ),
                        ListTile(
                          leading: Text("Jumlah SKS :"),
                          title: Text(sks),
                        ),
                        
                      ],
                    );
                  },
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
