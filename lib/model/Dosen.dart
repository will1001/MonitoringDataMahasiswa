import 'package:cloud_firestore/cloud_firestore.dart';

class Dosen{
  
    getDataDosen(){
      return Firestore.instance
              .collection('dosen')
              .snapshots();
    }
}