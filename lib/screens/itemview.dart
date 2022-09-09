import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lostandfound/models/item.dart';

class itempage extends StatefulWidget {

  Profile_item profile;
  int index;
  itempage({required this.profile,required this.index});
  @override
  State<itempage> createState() => _itempageState();
}
String a="";
class _itempageState extends State<itempage> {

  @override
  Widget build(BuildContext context) {
    Profile_item profile = widget.profile;
    if (profile.cat.toString().trim()=="Lost")
      a="Lost By";
      else
        a="Found By";
    return Scaffold(
      backgroundColor: Color.fromRGBO(12,65,96,0.3),
      body: Container(
        child: Column(
            children: <Widget>[
              SizedBox(height:200),
              Text(profile.p_name,style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
              SizedBox(height: 5),
              Row( mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Details: ',
                    style: TextStyle(color: Colors.black87,fontSize: 20,fontStyle: FontStyle.italic,),),
                  Text(
                    profile.desc,
                    style: TextStyle(color: Colors.black87,fontSize: 20,fontWeight: FontWeight.w500,),),
                ],
              ),
              SizedBox(height: 5),
              Row( mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    a+": ",
                    style: TextStyle(color: Colors.black87,fontSize: 20,fontStyle: FontStyle.italic,),),
                  Text(
                    profile.username,
                    style: TextStyle(color: Colors.black87,fontSize: 20,fontWeight: FontWeight.w500,),),
                ],
              ),

              SizedBox(height: 40),

              Row( mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    color:  Colors.white,
                    child: Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: Color.fromRGBO(12,65,96,1),
                          size: 19.0,
                        ),
                        Text(
                          'Contact',
                          style: TextStyle(color: Color.fromRGBO(12,65,96,1), fontSize: 20.0),
                        ),
                      ],
                    ),
                    onPressed: (){  },
                  ),
                ],
              ),

            ]),
      ),

    );
  }
}
