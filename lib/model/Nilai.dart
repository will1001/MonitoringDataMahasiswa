import 'package:cloud_firestore/cloud_firestore.dart';

class Nilai{
    getdatanilai(){
      return Firestore.instance
              .collection('nilai')
              .snapshots();
    }
    
   getDataNilaiWhereNIM(String nim){
      return Firestore.instance
              .collection('nilai')
              .where("nim", isEqualTo: nim)
              .snapshots();
    }
}