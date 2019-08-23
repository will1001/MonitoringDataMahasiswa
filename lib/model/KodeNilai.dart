import 'package:cloud_firestore/cloud_firestore.dart';

class KodeNilai{
  
    getDataKodeNilai(){
      return Firestore.instance
              .collection('kode_nilai')
              .getDocuments();
    }
}