import 'package:data_monitoring_mahasiswa/Form/FormEditDataMahasiswa.dart';
import 'package:data_monitoring_mahasiswa/model/Dosen.dart';
import 'package:data_monitoring_mahasiswa/model/Mahasiswa.dart';
import 'package:data_monitoring_mahasiswa/model/Takhir.dart';
import 'package:data_monitoring_mahasiswa/model/Users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'DataNilaiMahasiswaPage.dart';
import 'Mahasiswapage.dart';

class DataSkripsiMahasiswapage extends StatefulWidget {
  @override
  _DataSkripsiMahasiswapageState createState() => _DataSkripsiMahasiswapageState();
}

class _DataSkripsiMahasiswapageState extends State<DataSkripsiMahasiswapage> {

  String nim;

  @override
  void initState() {
    super.initState();
    getUID();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Skripsi'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
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
            height: 500.0,
            child: ListView.builder(
              itemCount: document.length,
              itemBuilder: (BuildContext context, int i) {
                String nim = document[i].data["nim"].toString();

                return StreamBuilder(
              stream: Takhir().getDataTakhirWhereNIM(nim),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return new Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );

                  List<DocumentSnapshot> takhir = snapshot.data.documents;
                String pmb1 = takhir[0].data["pmb1"].toString();
                String pmb2 = takhir[0].data["pmb2"].toString();
                String tgl_proposal = takhir[0].data["tgl_proposal"].toString();
                String tgl_shasil = takhir[0].data["tgl_shasil"].toString();
                String tgl_ujian = takhir[0].data["tgl_ujian"].toString();


                return StreamBuilder(
              stream: Dosen().getDataDosenWhereIdDosen(pmb1),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return new Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );

                  List<DocumentSnapshot> datanamapmb1 = snapshot.data.documents;
                String namapmb1 =datanamapmb1[0].data["nama_dosen"].toString();


                return StreamBuilder(
              stream: Dosen().getDataDosenWhereIdDosen(pmb2),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return new Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );

                  List<DocumentSnapshot> datanamapmb2 = snapshot.data.documents;
                String namapmb2 = datanamapmb2[0].data["nama_dosen"].toString();


                return new Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              children: <Widget>[
                                Text('Dosen Pembimbing 1'),
                                Padding(
                                  padding: const EdgeInsets.only(left: 37.0,right: 5.0),
                                  child: Text(':'),
                                ),
                                Expanded(child: Text(namapmb1)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              children: <Widget>[
                                Text('Dosen Pembimbing 2'),
                                Padding(
                                  padding: const EdgeInsets.only(left: 39.0,right: 5.0),
                                  child: Text(':'),
                                ),
                                Expanded(child: Text(namapmb2)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              children: <Widget>[
                                Text('Tanggal Seminar Proposal'),
                                Padding(
                                  padding: const EdgeInsets.only(left: 9.0,right: 5.0),
                                  child: Text(':'),
                                ),
                                Text(tgl_proposal),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              children: <Widget>[
                                Text('Tanggal Seminar Hasil'),
                                Padding(
                                  padding: const EdgeInsets.only(left: 36.0,right: 5.0),
                                  child: Text(':'),
                                ),
                                Text(tgl_shasil),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              children: <Widget>[
                                Text('Tanggal Ujian'),
                                Padding(
                                  padding: const EdgeInsets.only(left: 93.0,right: 5.0),
                                  child: Text(':'),
                                ),
                                Text(tgl_ujian),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              children: <Widget>[
                                Text('Lama Proposal'),
                                Padding(
                                  padding: const EdgeInsets.only(left: 87.0,right: 5.0),
                                  child: Text(':'),
                                ),
                                Text(HitungLamaPropsal(tgl_shasil, tgl_ujian)),
                                Text('  Bulan'),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Row(
                              children: <Widget>[
                                Text('Lama Hasil'),
                                Padding(
                                  padding: const EdgeInsets.only(left: 115.0,right: 5.0),
                                  child: Text(':'),
                                ),
                                Text(HitungLamaHasil(tgl_proposal, tgl_shasil)),
                                Text('  Bulan'),
                              ],
                            ),
                          ),
                        ],
                      ),
                );
              },
            );
              },
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

  String HitungLamaPropsal(String tgl_propopsal,String tgl_hasil){
    var bulanproposal=int.parse(tgl_propopsal.substring(5,7));
    var bulanhasil=int.parse(tgl_hasil.substring(5,7));
    var lamaproposal = bulanhasil - bulanproposal;
    if(lamaproposal<0){
      lamaproposal*=-1;
    }
    return lamaproposal.toString();
  }
  
  String HitungLamaHasil(String tgl_hasil,String tgl_ujian){
    var bulanhasil=int.parse(tgl_hasil.substring(5,7));
    var bulanujian=int.parse(tgl_ujian.substring(5,7));
    var lamahasil = bulanujian - bulanhasil;
    if(lamahasil<0){
      lamahasil*=-1;
    }
    return lamahasil.toString();
  }
}
