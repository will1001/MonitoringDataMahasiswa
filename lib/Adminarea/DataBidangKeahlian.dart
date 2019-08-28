import 'package:data_monitoring_mahasiswa/Form/FormEditDataBidangKeahlian.dart';
import 'package:data_monitoring_mahasiswa/Form/FormTambahDataBidangKeahlian.dart';
import 'package:data_monitoring_mahasiswa/model/BidangKeahlian.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DataBidangKeahlian extends StatefulWidget {
  @override
  _DataBidangKeahlianState createState() => _DataBidangKeahlianState();
}

class _DataBidangKeahlianState extends State<DataBidangKeahlian> {
  String onchange;

  
@override
  void initState() {
    super.initState();
    getUID();
    
  }  

String _keterangan,_kode_bk,_nama_bk;

String _dataku;

 void _adddata() {
    Navigator.of(context).push(
    MaterialPageRoute(builder: (c) => FormTambahDataBidangKeahlian())
  );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Bidang Keahlian'),
        actions: <Widget>[
          IconButton(
          icon: Icon(Icons.menu),
          onPressed: (){
            
          },
        ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           StreamBuilder(
             stream: BidangKeahlian().getDataBidangKeahlian(),

             builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
               if(!snapshot.hasData)
               return new Container(child: Center(
                 child: CircularProgressIndicator(),
               ),);

               return new TampilData(document: snapshot.data.documents,);
             },
           ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adddata,
        tooltip: 'Adddata',
        child: Icon(Icons.add),
      ), 
    );
  }
  getUID() async {
    
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user = await _auth.currentUser();
  String uid = user.uid;
  _dataku = uid;
   return  uid;
  }

}


class TampilData extends StatelessWidget {
  TampilData({this.document});
  final List<DocumentSnapshot> document;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: SizedBox(
            height: 500.0,
            width: 500.0,
            child: ListView.builder(
                    itemCount: document.length,
                    itemBuilder: (BuildContext context, int i){
                      String keterangan = document[i].data["keterangan"].toString();
                      String kode_bk = document[i].data["kode_bk"].toString();
                      String nama_bk = document[i].data["nama_bk"].toString();
                      


                      return ExpansionTile(
                        title: Text(nama_bk),
                        children: <Widget>[
                          ListTile(
                            leading: Text("Kode BK :"),
                          title: Text(kode_bk),
                        ),
                          ListTile(
                            leading: Text("Keterangan:"),
                          title: Text(keterangan),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context)=> FormEditDataBidangKeahlian(
                                  keterangan: document[i].data['keterangan'],
                                  kode_bk: document[i].data['kode_bk'],
                                  nama_bk: document[i].data['nama_bk'],
                                  index:document[i].reference,
                                )
                              ));
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: (){
                              Firestore.instance.runTransaction((Transaction transaction)async{
                                DocumentSnapshot snapshot = 
                                await transaction.get(document[i].reference);
                                await transaction.delete(snapshot.reference);
                              });
                            },
                          )
                          ],
                        )
                        ],
                      );
                    },
                  ),
          ),
        )
      ],
    );
  }
}