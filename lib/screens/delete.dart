import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lostandfound/listview/pt.dart';
import '../extras/flash.dart';
import '../listview/deletetile.dart';
import '../models/item.dart';

class delete extends StatefulWidget {
  String id;
  delete({required this.id});

  @override
  _deleteState createState() => _deleteState();
}

class _deleteState extends State<delete> {
  @override
  List<String> p_name=[];
  List<String> uname=[];
  List<String> uid=[];
  List<String> p_cat=[];
  List<String> p_url=[];
  List<String> p_desc=[];

  int c=0;
  Widget build(BuildContext context) {
    String id=widget.id;
    c=0;
    print('task delete');
    print(id);
    final Stream<QuerySnapshot> _productStream = FirebaseFirestore.instance.collection('product').snapshots();
    _productStream.forEach((product) {
      product.docs.asMap().forEach((index, data) {
        print(product.docs[index]['uid'].toString());
        if(product.docs[index]['uid'].toString().trim()==id){
          c=c+1;
          p_name.add(product.docs[index]['name']);
          p_cat.add(product.docs[index]['cat']);
          p_desc.add(product.docs[index]['desc']);
          p_url.add(product.docs[index]['url']);
          uname.add(product.docs[index]['username']);
          uid.add(product.docs[index]['userid']);
        }
      });});
    // DocumentReference documentReference = FirebaseFirestore.instance.collection('product').doc();
    // print('hello');
    // print(documentReference.id);

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: new PreferredSize(
        child: new Container(
          color: Color.fromRGBO(12,65,96,1),
          padding: new EdgeInsets.only(
              top: MediaQuery.of(context).padding.top
          ),
          child: new Padding(
            padding: const EdgeInsets.only(
                left: 30.0,
                top: 20.0,
                bottom: 20.0
            ),
            child: new Text(
              '${id.toUpperCase()}',
              style: new TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
              ),
            ),
          ),
        ),
        preferredSize: new Size(
            MediaQuery.of(context).size.width,
            130.0
        ),
      ),

      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('product').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(!snapshot.hasData){return Center(child: CircularProgressIndicator());}
            final documentSnapshotList = snapshot.data!.docs.where((element) => element['uid']==id);
            c = documentSnapshotList.length;
            if (!snapshot.hasData) {
              return Center(child: Text("snapshot has no data"));
            }
            else {
              if (c == 0) {
                return Flash();
              }
              else{
                final profile = List<Profile_item>.generate(c, (i) => Profile_item(p_name: p_name[i],cat:p_cat[i],desc: p_desc[i]));
                return ListView.builder(
                  itemCount: profile.length,
                  itemBuilder: (context, index) {
                    return deletetile(profile: profile[index],ind:index);},
                );
              }
            }}),
    );
  }
}