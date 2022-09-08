import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lostandfound/models/item.dart';
import '../listview/itemprofile.dart';
import '../listview/pt.dart';
import 'flash.dart';
import 'notfound.dart';


class search extends StatefulWidget {

  @override
  _searchState createState() => _searchState();
}

class _searchState extends State<search> {

  @override
  String interests="";
  List<String> itemName= [];
  List<String> itemdesc=[];
  List<String> p_url=[];
  List<String> itemcat=[];
  List<String> uName= [];
  List<String> id=[];
  List<String> pid=[];
  int c=0;
  Widget build(BuildContext context) {
    c=0;


    return Scaffold(
      appBar: new PreferredSize(
        child: new Container(
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
              'Search',
              style: new TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
              ),
            ),
          ),
          decoration: new BoxDecoration(
            color: Color.fromRGBO(92, 104, 211, .5),
          ),
        ),
        preferredSize: new Size(
            MediaQuery.of(context).size.width,
            130.0
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
            child: Container(
              height: 55,
              child: TextField(
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Color.fromRGBO(33, 57, 89, 1),
                    ),
                    onPressed: () {

                    },
                  ),
                  fillColor: Colors.white12,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                      BorderSide.none), // OutlineInputBo
                  hintText: ' Search ',
                  hintStyle: TextStyle(
                      color: Color.fromRGBO(33, 57, 89, 1),
                      fontSize: 17),
                ),
                onChanged: (val) {
                  setState(() => interests = val);
                },
              ),
            ),
          ),
       Container(
         height: 500,
         child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('product').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              print("hello");
              if(!snapshot.hasData){return Center(child: CircularProgressIndicator());}
              final documentSnapshotList = snapshot.data!.docs.where((element) => element['name']==interests.toString().trim());
              documentSnapshotList.forEach((element) {itemcat.add(element['cat']);uName.add(element['uname']);p_url.add(element['url']);id.add(element['uid']);pid.add(element['pid']);itemName.add(element['name']);
              itemdesc.add(element['desc']); });
              c = documentSnapshotList.length;
              if (!snapshot.hasData) {
                return Center(child: Text("snapshot has no data"));
              }
              else {
                if (c == 0) {
                  return Flash();
                }
                else{
                  final profile = List<Profile_item>.generate(c, (i) => Profile_item(p_name: itemName[i],cat:itemcat[i],desc: itemdesc[i], userid: id[i], username:uName[i], url: p_url[i], pid: pid[i],));
                  return ListView.builder(
                    itemCount: profile.length,
                    itemBuilder: (context, index) {
                      return profiletile(profile: profile[index],ind:index);},
                  );
                }
              }}),
       ),
        ],
      ),
    );
  }
}