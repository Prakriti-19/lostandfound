import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lostandfound/models/item.dart';
import '../listview/itemprofile.dart';
import 'flash.dart';


class search extends StatefulWidget {
  String interests;
  search({required this.interests});

  @override
  _searchState createState() => _searchState();
}

class _searchState extends State<search> {

  @override
  List<String> profileName= [];
  List<String> profilepno=[];
  List<String> profilroll=[];
  List<String> uname=[];
  List<String> uid=[];
  List<String> p_url=[];
  int c=0;
  Widget build(BuildContext context) {
    c=0;
    print('entered build');
    print(c);
    String interests=widget.interests;

    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('profile').snapshots();
    _usersStream.forEach((profile){
      profile.docs.asMap().forEach((index,data){
        if ((profile.docs[index]['interests']).toString().trim()==(interests).toString().trim())
        {
          profileName.add(profile.docs[index]['name']);
        }
      });
    });
    _usersStream.forEach((profile){
      profile.docs.asMap().forEach((index,data){
        if ((profile.docs[index]['interests']).toString().trim()==(interests).toString().trim()){
          profilroll.add(profile.docs[index]['rollno']);
        }
      });
    });
    _usersStream.forEach((profile){
      profile.docs.asMap().forEach((index,data){
        if ((profile.docs[index]['interests']).toString().trim()==(interests).toString().trim()) {
          profilepno.add(profile.docs[index]['pno']);
          c=c+1;
          print('update');
          print(c);
        }
      });
    });
    _usersStream.forEach((profile){
      profile.docs.asMap().forEach((index,data){
        if ((profile.docs[index]['interests']).toString().trim()==(interests).toString().trim())
          uname.add(profile.docs[index]['username']);
        print(uname[index]);
      });
    });
    _usersStream.forEach((profile){
      profile.docs.asMap().forEach((index,data){
        if ((profile.docs[index]['interests']).toString().trim()==(interests).toString().trim())
          uid.add(profile.docs[index]['userid']);
        print(uid[index]);
      });
    });
    _usersStream.forEach((profile){
      profile.docs.asMap().forEach((index,data){
        if(profile.docs[index]['cat']=='Found')
          p_url.add(profile.docs[index]['url']);
        print(uid[index]);
      });
    });

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
              '${interests}',
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
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('profile').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(!snapshot.hasData){return Center(child: CircularProgressIndicator());}
            final documentSnapshotList = snapshot.data!.docs.where((element) => element['interests']==interests);
            // c = documentSnapshotList.length;
            print('enetered stream builder');
            print(c);
            if (!snapshot.hasData) {
              return Center(child: Text("snapshot has no data"));
            }
            else {
              if (c == 0) {
                return Flash();
              }
              else{
                final profile = List<Profile_item>.generate(c, (i) => Profile_item(p_name: profilroll[i],desc: profileName[i], cat:profilepno[i]),);
                return ListView.builder(
                  itemCount: profile.length,
                  itemBuilder: (context, index) {
                    return profiletile(profile: profile[index],ind:index);},
                );
              }
            }}),
    );
  }
}