import 'package:flutter/material.dart';
import 'package:lostandfound/models/item.dart';

import '../screens/itemview.dart';

class profiletile extends StatefulWidget {

  final Profile_item profile;
  int ind;
  profiletile({required this.profile, required this.ind});

  @override
  State<profiletile> createState() => _profiletileState();
}

class _profiletileState extends State<profiletile> {
  Tween<Offset> _offset =Tween(begin : Offset (1, 0), end: Offset (0, 0));


  @override
  Widget build(BuildContext context) {
    Profile_item profile=widget.profile;
    return AnimatedContainer(
      duration: Duration(microseconds: 200),
      child: Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Stack(children: <Widget>[
          Container(
            height: 90,
            color: Colors.white38,
            child: Row(children: <Widget>[
              SizedBox(
                width: 6,
              ),
              Container(
                width: 195,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children:<Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.profile.p_name,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '${widget.profile.desc} ',
                        style: TextStyle(fontSize: 15),
                      ),
                    ]),
              ),

              Container(
                width: 80,
                child: RaisedButton(
                  hoverElevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  color: Colors.white,
                  child: Text(
                    'View',
                    style:
                    TextStyle(color: Color.fromRGBO(92, 104, 211, .5)),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            itempage(profile: widget.profile, index: widget.ind)),
                  ),
                ),
              ),
            ],
            ),
          )]),
      ),

    );
  }
}
