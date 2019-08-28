import 'package:cloud_firestore/cloud_firestore.dart';

class Takhir{
  
    getDataTakhir(){
      return Firestore.instance
              .collection('takhir')
              .snapshots();
    }

    getDataTakhirWhereNIM(String nim){
      return Firestore.instance
              .collection('takhir')
              .where("nim", isEqualTo: nim)
              .snapshots();
    }
}