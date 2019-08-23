import 'package:cloud_firestore/cloud_firestore.dart';

class SekolahAsal{
  
    getDataSekolahAsal(){
      return Firestore.instance
              .collection('sekolah_asal')
              .getDocuments();
    }
}