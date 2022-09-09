import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/item.dart';


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
       
    int index=widget.ind;
    String a;
    if(widget.profile.desc.length<15)
      a=widget.profile.desc;
    else
      a=widget.profile.desc.substring(0,13)+'...';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7,vertical: 10),
      child: Stack(children: <Widget>[
        Material(
          elevation: 12,
          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
          child: Card(
            child: Container(
              height: 235,
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        decoration: new BoxDecoration(
                            image: DecorationImage(image: NetworkImage(profile.url))),)),
                  SizedBox(
                    width: 9,
                  ),
                  Text(
                    ' ${widget.profile.p_name.toUpperCase()} ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17,color: Colors.black),
                  ),
                  SizedBox(
                    height: 0.5,
                  ),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Container(
                        width: 318,
                        child: Text(
                          '${widget.profile.desc} ',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                Container(

                  child: RaisedButton(child:Text("Delete",style: TextStyle(color: Colors.white),),color: Color.fromRGBO(92, 104, 211, .5),onPressed: (){FirebaseFirestore.instance
        .collection('product')
        .doc(profile.pid)
        .delete();}),
                )
                ],
              ),

            ),
          ),
        )]),);
  }
}
