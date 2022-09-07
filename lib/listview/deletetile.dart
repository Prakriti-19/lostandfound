import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/item.dart';
import '../screens/itemview.dart';


class deletetile extends StatefulWidget {
  final Profile_item profile;
 // String id;
  int ind;
  deletetile({required this.profile, required this.ind});

  @override
  _deletetileState createState() => _deletetileState();
}
CollectionReference users = FirebaseFirestore.instance.collection('product');

class _deletetileState extends State< deletetile> {
  @override
  Widget build(BuildContext context) {
    final _db=FirebaseFirestore.instance;
    Profile_item profile = widget.profile;
   // String id=widget.id;
    int index=widget.ind;
    String a;
    if(widget.profile.desc.length<75)
      a=widget.profile.desc;
    else
      a=widget.profile.desc.substring(0,73)+'...';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7,vertical: 10),
      child: Stack(children: <Widget>[
        Material(
          elevation: 12,
          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
          child: Card(
            child: Container(
              height: 180,
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        decoration: new BoxDecoration(
                            image: DecorationImage(image: AssetImage('logo.png'))),)),
                  SizedBox(
                    width: 9,
                  ),
                  Text(
                    '  ${widget.profile.p_name.toUpperCase()} ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.black54),
                  ),
                  SizedBox(
                    height: 0.5,
                  ),
                  Text(
                    '  ${widget.profile.desc.toUpperCase()} ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.black54),
                  ),

                  Container(
                    width: 50,
                    child: IconButton(
                      color:Color.fromRGBO(12,65,96,1),
                      onPressed: ()async{ await _db.collection('product').doc().delete();},
                      padding: EdgeInsets.symmetric(vertical: 0),
                      icon: Icon(Icons.delete),
                    ),
                  ),
                ],
              ),

            ),
          ),
        )]),);
  }
}
