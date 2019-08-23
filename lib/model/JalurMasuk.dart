import 'package:cloud_firestore/cloud_firestore.dart';

class JalurMasuk{
  
    getDataJalurMasuk(){
      return Firestore.instance
              .collection('jalur_masuk')
              .getDocuments();
    }
}