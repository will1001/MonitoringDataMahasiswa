import 'package:cloud_firestore/cloud_firestore.dart';

class MahasiswaStatus{
  
    getDataMahasiswaStatus(){
      return Firestore.instance
              .collection('mhs_status')
              .getDocuments();
    }
}