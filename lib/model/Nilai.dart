import 'package:cloud_firestore/cloud_firestore.dart';

class Nilai{
    getdatanilai(){
      return Firestore.instance
              .collection('nilai')
              .snapshots();
    }
}