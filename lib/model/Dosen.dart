import 'package:cloud_firestore/cloud_firestore.dart';

class Dosen{
  
    getDataDosen(){
      return Firestore.instance
              .collection('dosen')
              .snapshots();
    }
    
    getDataDosenWhereIdDosen(String id_dosen){
      return Firestore.instance
              .collection('dosen')
              .where('id_dosen',isEqualTo: id_dosen)
              .snapshots();
    }
}