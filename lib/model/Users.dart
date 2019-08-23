import 'package:cloud_firestore/cloud_firestore.dart';

class Users{
  
    getDataUsers(){
      return Firestore.instance
              .collection('users')
              .getDocuments();
    }
}