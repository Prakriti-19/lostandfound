import 'package:flutter/material.dart';
import '../models/item.dart';
import '../screens/itemview.dart';


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
                        height: 100,
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
