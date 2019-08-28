import 'package:cloud_firestore/cloud_firestore.dart';

class Mahasiswa{
  
    getDataMahasiswa(){
      return Firestore.instance
              .collection('mahasiswa')
              .snapshots();
    }


    getDataMahasiswaWhereNIM(String nim){
      return Firestore.instance
              .collection('mahasiswa')
              .where("nim", isEqualTo: nim)
              .snapshots();
    }
}