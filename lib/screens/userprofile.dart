import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Userprof extends StatefulWidget {


  String name;
  String pno;
  String rollno;
  String email;
  Userprof({required this.rollno,required this.name,required this.pno,required this.email});
  @override
  _UserprofState createState() => _UserprofState();
}

class _UserprofState extends State<Userprof> {
  @override
  Widget build(BuildContext context) {
    String name=widget.name;
    String pno=widget.pno;
    String rollno=widget.rollno;
    String email=widget.email;

    return Scaffold(
     // backgroundColor: Color.fromRGBO(33, 57, 89, 1),
      body: Container(
          width: double.infinity,
          child: Container(
            child: Column(
                children: <Widget>[
                  SizedBox(height:60),
                  Container(
                    height: 300,
                    decoration: new BoxDecoration( image: DecorationImage(image:AssetImage('images/profile.png'))),
                  ),
                  SizedBox(height:100),
                  Text('${name}',style: TextStyle(color: Color.fromRGBO(12,65,96,1),fontSize: 25,fontWeight: FontWeight.bold),),
                  SizedBox(height: 5),
                  Row( mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Contact No.: ',
                        style: TextStyle(color: Color.fromRGBO(12,65,96,.7),fontSize: 20,fontStyle: FontStyle.italic,),),
                      Text(
                        ' ${pno}',
                        style: TextStyle(color: Color.fromRGBO(12,65,96,.7),fontSize: 20,fontWeight: FontWeight.w500,),),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row( mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Roll no.: ',
                        style: TextStyle(color: Color.fromRGBO(12,65,96,.7),fontSize: 20,fontStyle: FontStyle.italic,),),
                      Text(
                        ' ${rollno}',
                        style: TextStyle(color: Color.fromRGBO(12,65,96,.7),fontSize: 20,fontWeight: FontWeight.w500,),),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row( mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Email: ',
                        style: TextStyle(color: Color.fromRGBO(12,65,96,.7),fontSize: 20,fontStyle: FontStyle.italic,),),
                      Text(
                        ' ${email}',
                        style: TextStyle(color: Color.fromRGBO(12,65,96,.7),fontSize: 20,fontWeight: FontWeight.w500,),),
                    ],
                  ),

                ]),
          )),
    );
  }
}
