import 'package:flutter/material.dart';
import 'package:lostandfound/screens/itemprofile.dart';
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
    if(widget.profile.desc.length<55)
      a=widget.profile.desc;
    else
      a=widget.profile.desc.substring(0,53)+'...';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7,vertical: 10),
      child: Stack(children: <Widget>[
        Material(
          elevation: 12,
          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
          child: Card(
            child: Container(
              height: 75,
              decoration: new BoxDecoration(
                  border:  Border.all(
                    color:Color.fromRGBO(12,65,96,1), //                   <--- border color
                    width: 3.0,
                  ),
                  color: Colors.blue[50],
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(children: <Widget>[
                SizedBox(
                  width: 2,
                ),
                Container(
                  width: 270,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                      children:<Widget>[
                        SizedBox(
                          width: 9,
                        ),
                        Text(
                          '  ${widget.profile.p_name.toUpperCase()} ',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.black54),
                        ),
                        SizedBox(
                          height: 2.5,
                        ),
                        Row(
                          children: [
                            SizedBox(width: 4,),
                            Container(
                              width: 265,
                              child: Text(
                                ' ${a}',
                                style: TextStyle(fontSize: 15,color: Colors.black38),
                              ),
                            ),
                          ],
                        ),
                      ]),
                ),
                Container(
                  width: 50,
                  child: IconButton(
                    color:Color.fromRGBO(12,65,96,1),
                    onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>itempage(profile: profile, index: index,)));},
                    padding: EdgeInsets.symmetric(vertical: 0),
                    icon: Icon(Icons.double_arrow_outlined),
                  ),
                ),
              ],
              ),
            ),
          ),
        )]),);
  }
}
