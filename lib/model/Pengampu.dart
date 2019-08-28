import 'package:cloud_firestore/cloud_firestore.dart';

class Pengampu{
  
    getDataPengampu(){
      return Firestore.instance
              .collection('pengampu')
              .snapshots();
    }
}