import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../extras/flash.dart';
import '../extras/notfound.dart';
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

  int c=0;
  Widget build(BuildContext context) {

    List<String> p_url=[];
    List<String> itemName= [];
    List<String> itemdesc=[];
    List<String> itemcat=[];
    List<String> uName= [];
    List<String> uid=[];
    List<String> pid=[];
    List<Color> color=[];
    String id=widget.id;
    c=0;

    return Scaffold(
      appBar: new PreferredSize(
        child: new Container(
          color: Color.fromRGBO(92, 104, 211, .5),
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
              'Your Enlistments',
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
            final documentSnapshotList = snapshot.data!.docs.where((element) => element['uid']==id.toString());
            documentSnapshotList.forEach((element) {itemcat.add(element['cat'].toString());uName.add(element['uname']);uid.add(element['uid']);pid.add(element['pid']);p_url.add(element['url'].toString());itemName.add(element['name']);
            itemdesc.add(element['desc']); });
            c = documentSnapshotList.length;
              if (c == 0) {
                return Flash();
              }
              else{
                final profile = List<Profile_item>.generate(c, (i) => Profile_item(p_name: itemName[i],cat:itemcat[i],desc: itemdesc[i],userid: uid[i], username:uName[i], url: p_url[i],pid: pid[i],));
                return ListView.builder(
                  itemCount: profile.length,
                  itemBuilder: (context, index) {
                    return deletetile(profile: profile[index],ind:index);},
                );
              }
            }),
    );
  }
}