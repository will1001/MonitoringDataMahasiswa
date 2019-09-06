import 'package:cloud_firestore/cloud_firestore.dart';

class MataKuliah{
  
    getDataMataKuliah(){
      return Firestore.instance
              .collection('matakuliah')
              .snapshots();
    }
    
    getDataMataKuliahWhereKodeMk(String kode_mk){
      return Firestore.instance
              .collection('matakuliah')
              .where("kode_mk", isEqualTo: kode_mk)
              .snapshots();
    }
}