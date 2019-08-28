import 'package:cloud_firestore/cloud_firestore.dart';

class MataKuliah{
  
    getDataMataKuliah(){
      return Firestore.instance
              .collection('matakuliah')
              .snapshots();
    }
}