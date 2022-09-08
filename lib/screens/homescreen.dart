import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lostandfound/listview/itemadd.dart';
import 'package:lostandfound/models/user.dart';
import 'package:provider/provider.dart';
import 'package:lostandfound/extras/loading.dart';
import '../listview/drawer.dart';
import '../listview/pt.dart';
import '../models/item.dart';
import 'found.dart';
class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class Customshape extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height-50);
    path.quadraticBezierTo(width/2, height, width, height-50);
    path.lineTo(width, 0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class _HomeScreenState extends State<HomeScreen>{
 @override

  int c = 0; bool loading=false;



  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User usser = auth.currentUser!;
    List<String> itemName= [];
    List<String> itemdesc=[];
    List<String> p_url=[];
    List<String> itemcat=[];
    List<String> uName= [];
    List<String> id=[];

      return loading? Loading():Scaffold(

        appBar: AppBar(
          toolbarHeight: 105,
          backgroundColor: Color.fromRGBO(92, 104, 211, .5),
          elevation: 0.0,
          flexibleSpace: ClipPath(
            clipper: Customshape(),
                child:Container(
                  height: 190,
                  width: MediaQuery.of(context).size.width,
                  color: Color.fromRGBO(92, 104, 211, .5),
                  child: Center(child: Text("Hello!",style: TextStyle(fontSize: 28,color:  Colors.white,fontWeight: FontWeight.bold),)),
                ),
          ),),
        drawer: mDrawer(
          user: usser,
        ), //DrawerHeader
        body:Container(
            child:Column(
              children: [
                Row(
                  children: [
                    Container(
                      child: TextButton(onPressed: (){},
                          child: Text('  LOST',style: TextStyle(color: Color.fromRGBO(12,65,96,1),fontSize: 20,fontWeight: FontWeight.bold),)),
                    ),
                    SizedBox(width:200 ,),
                    Container(
                        child: TextButton(onPressed: (){   setState(() {

                        });
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Found()));}, child: Text('FOUND',style: TextStyle(color: Colors.black38,fontSize: 20,fontWeight: FontWeight.bold),)),
                    )
                  ],
                ),
                SingleChildScrollView(
                  child: Container(
                    height: 490,
                    width: 350,
                    child: StreamBuilder<QuerySnapshot>(
                        stream:
                        FirebaseFirestore.instance.collection('product').snapshots(),
                        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if(!snapshot.hasData){return Center(child: CircularProgressIndicator());}
                          final documentSnapshotList = snapshot.data!.docs.where((element) => element['cat']=="Lost");
                          documentSnapshotList.forEach((element) {itemcat.add(element['cat']);uName.add(element['uname']);p_url.add(element['url']);id.add(element['uid']);itemName.add(element['name']);
                          itemdesc.add(element['desc']); });

                          c = documentSnapshotList.length;
                          print(c);
                          print(itemName[1]);
                          if (!snapshot.hasData) {
                            return Text('snapshot does not have data');
                          }
                          else{
                            final profile_item = List<Profile_item>.generate(c, (i) => Profile_item(p_name: itemName[i],cat:itemcat[i],desc: itemdesc[i], userid: id[i], username:uName[i], url: p_url[i],));
                            return ListView.builder(
                              itemCount: profile_item.length,
                              itemBuilder: (context, index) {
                                return profiletile(profile: profile_item[index],ind:index);},
                            );
                          }
                        }
                    ),
                  ),
                ),

              ],
            )));
  }
}


