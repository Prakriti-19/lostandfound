import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/item.dart';


class profiletile extends StatefulWidget {
  final Profile_item profile;
  int ind;
  profiletile({required this.profile, required this.ind});

  @override
  _profiletileState createState() => _profiletileState();
}

class _profiletileState extends State<profiletile> {
  @override
  Widget build(BuildContext context) {
    Profile_item profile = widget.profile;
    String a;
    int index=widget.ind;
    if(widget.profile.desc.length<25)
      a=widget.profile.desc;
    else
      a=widget.profile.desc.substring(0,23)+'...';
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 7,vertical: 10),
        child: Stack(children: <Widget>[
          Material(
            borderRadius: BorderRadius.all(Radius.circular(18)),
              color: Color.fromRGBO(92, 104, 211, .5),
              elevation: 12,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  child: Container(
                    decoration: new BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(18))),
                    height: 240,
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              height: 120,
                              width: 200,
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(18)),
                                  image: DecorationImage(image:NetworkImage(profile.url),fit: BoxFit.fill)),)),
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
                              width: 300,
                              child: Text(
                                '${widget.profile.desc} ',
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14,color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Text(
                              'Roll no: ',
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13,color: Colors.black87),
                            ),
                            SizedBox(width: 3),
                            Text(
                              '${widget.profile.roll} ',
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13,color: Colors.black87),
                            ),

                          ],

                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Text(
                              'Contact no :',
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13,color: Colors.black87),
                            ),
                            SizedBox(width: 3),
                            Text(
                              '${widget.profile.uno} ',
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13,color: Colors.black87),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )),]));
  }
}
