import 'package:cloud_firestore/cloud_firestore.dart';

class Nilai{
    getdatanilai(String kode_mk){
      return Firestore.instance
              .collection('nilai')
              .where("kode_mk", isEqualTo: kode_mk)
              .getDocuments();
    }
}