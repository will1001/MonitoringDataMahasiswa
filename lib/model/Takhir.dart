import 'package:cloud_firestore/cloud_firestore.dart';

class Takhir{
  
    getDataTakhir(){
      return Firestore.instance
              .collection('takhir')
              .getDocuments();
    }
}