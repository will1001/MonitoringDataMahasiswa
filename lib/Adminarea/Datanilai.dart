import 'package:data_monitoring_mahasiswa/Adminarea/DataDetailnilai.dart';
import 'package:data_monitoring_mahasiswa/model/MataKuliah.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Datanilai extends StatefulWidget {
  @override
  _DatanilaiState createState() => _DatanilaiState();
}

class _DatanilaiState extends State<Datanilai> {
  
@override
  void initState() {
    super.initState();
    getUID();
    
  }  


String _dataku;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Nilai'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           StreamBuilder(
             stream: MataKuliah().getDataMataKuliah(),

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
                      String nama_mk = document[i].data["nama_mk"].toString();

                      return ListTile(
                        title: Text(nama_mk),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context)=> DataDetailnilai(
                                  kode_mk: document[i].data['kode_mk'],
                                  index:document[i].reference,
                                )
                              ));
                        },
                      );
                    },
                  ),
          ),
        )
      ],
    );
  }
}