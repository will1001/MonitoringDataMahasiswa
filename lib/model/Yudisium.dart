import 'package:cloud_firestore/cloud_firestore.dart';

class Yudisium{
  
    getDataYudisium(){
      return Firestore.instance
              .collection('yudisium')
              .getDocuments();
    }
}