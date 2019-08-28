import 'package:cloud_firestore/cloud_firestore.dart';

class JalurMasuk{
  
    getDataJalurMasuk(){
      return Firestore.instance
              .collection('jalur_masuk')
              .snapshots();
    }

    getDataJalurMasukWhereNIM(String nim){
      return Firestore.instance
              .collection('jalur_masuk')
              .where("nim", isEqualTo: nim)
              .snapshots();
    }
}