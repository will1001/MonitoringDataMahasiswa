import 'package:cloud_firestore/cloud_firestore.dart';

class BidangKeahlian{
  
    getDataBidangKeahlian(){
      return Firestore.instance
              .collection('bkeahlian')
              .snapshots();
    }
}