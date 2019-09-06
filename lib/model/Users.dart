import 'package:cloud_firestore/cloud_firestore.dart';

class Users{
  
    getDataUsers(){
      return Firestore.instance
              .collection('users')
              .snapshots();
    }
    
    getDataUsersWhereDoc(String username){
      return Firestore.instance
              .collection('users')
              .where("username", isEqualTo: username)
              .snapshots();
    }
}