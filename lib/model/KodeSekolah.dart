import 'package:cloud_firestore/cloud_firestore.dart';

class KodeSekolah{
  
    getDataKodeSekolah(){
      return Firestore.instance
              .collection('kode_sekolah')
              .getDocuments();
    }
}