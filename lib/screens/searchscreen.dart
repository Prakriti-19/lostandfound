import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../extras/notfound.dart';
import '../listview/pt.dart';
import '../models/item.dart';

class Ss extends StatefulWidget {

 String inter;
 Ss({required this.inter});
  @override
  State<Ss> createState() => _SsState();
}

class _SsState extends State<Ss> {
  @override
  Widget build(BuildContext context) {
    String interests = widget.inter;
    List<String> itemName = [];
    int c = 0;
    List<String> itemdesc = [];
    List<String> p_url = [];
    List<String> itemcat = [];
    List<String> uName = [];
    List<String> id = [];
    List<String> roll = [];
    List<String> uno = [];
    List<String> pid = [];
    return Scaffold(
        body:Container(
      height: 500,
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('product').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            print("hello");
            print(interests.toString().trim());
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            final documentSnapshotList = snapshot.data!.docs.where((
                element) => element['name'] == interests.toString().trim());
            documentSnapshotList.forEach((element) {
              itemcat.add(element['cat']);
              uName.add(element['uname']);
              roll.add(element['roll']);
              uno.add(element['uno']);
              p_url.add(element['url']);
              id.add(element['uid']);
              pid.add(element['pid']);
              itemName.add(element['name']);
              itemdesc.add(element['desc']);
              print(3);
              print(element['name']);
            });
            c = documentSnapshotList.length;
            if (!snapshot.hasData) {
              return Center(child: Text("snapshot has no data"));
            }
            else {
              if (c == 0) {
                return Flash();
              }
              else {
                final profile = List<Profile_item>.generate(c, (i) =>
                    Profile_item(p_name: itemName[i],
                      cat: itemcat[i],
                      desc: itemdesc[i],
                      userid: id[i],
                      username: uName[i],
                      url: p_url[i],
                      pid: pid[i],
                      uno: uno[i],
                      roll: roll[i],));
                return ListView.builder(
                  itemCount: profile.length,
                  itemBuilder: (context, index) {
                    return profiletile(profile: profile[index], ind: index);
                  },
                );
              }
            }
          })));
  }
}
