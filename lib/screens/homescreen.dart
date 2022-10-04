import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lostandfound/extras/loading.dart';
import 'drawer.dart';
import '../listview/profiletile.dart';
import '../models/item.dart';
import 'found.dart';

class Customshape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height - 50);
    path.quadraticBezierTo(width / 2, height, width, height - 50);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  int c = 0;
  bool loading = false;

  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser!;
    List<String> itemName = [];
    List<String> itemdesc = [];
    List<String> p_url = [];
    List<String> itemcat = [];
    List<String> uName = [];
    List<String> id = [];
    List<String> pid = [];
    List<String> roll = [];
    List<String> uno = [];

    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              toolbarHeight: 105,
              backgroundColor: Color.fromRGBO(92, 104, 211, .5),
              flexibleSpace: ClipPath(
                clipper: Customshape(),
                child: Container(
                  height: 190,
                  width: MediaQuery.of(context).size.width,
                  color: Color.fromRGBO(92, 104, 211, .5),
                  child: Center(
                      child: Text(
                    "Hello!",
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
            drawer: mDrawer(
              user: user,
            ), //DrawerHeader
            body: Container(
                child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            '  LOST',
                            style: TextStyle(
                                color: Color.fromRGBO(12, 65, 96, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    SizedBox(
                      width: 200,
                    ),
                    Container(
                      child: TextButton(
                          onPressed: () {
                            setState(() {});
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Found()));
                          },
                          child: Text(
                            'FOUND',
                            style: TextStyle(
                                color: Colors.black38,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),
                    )
                  ],
                ),
                SingleChildScrollView(
                  child: Container(
                    height: 490,
                    width: 350,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('product')
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }
                          final documentSnapshotList = snapshot.data!.docs
                              .where((element) => element['cat'] == "Lost");
                          documentSnapshotList.forEach((element) {
                            itemcat.add(element['cat']);
                            roll.add(element['roll']);
                            uno.add(element['uno']);
                            uName.add(element['uname']);
                            p_url.add(element['url']);
                            id.add(element['uid']);
                            pid.add(element['pid']);
                            itemName.add(element['name']);
                            itemdesc.add(element['desc']);
                          });
                          c = documentSnapshotList.length;
                          if (!snapshot.hasData) {
                            return Text('snapshot does not have data');
                          } else {
                            final profile_item = List<Profile_item>.generate(
                                c,
                                (i) => Profile_item(
                                      p_name: itemName[i],
                                      cat: itemcat[i],
                                      desc: itemdesc[i],
                                      userid: id[i],
                                      username: uName[i],
                                      url: p_url[i],
                                      pid: pid[i],
                                      uno: uno[i],
                                      roll: roll[i],
                                    ));
                            return ListView.builder(
                              itemCount: profile_item.length,
                              itemBuilder: (context, index) {
                                return profiletile(
                                    profile: profile_item[index], ind: index);
                              },
                            );
                          }
                        }),
                  ),
                ),
              ],
            )));
  }
}
