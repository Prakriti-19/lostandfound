import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Userprof extends StatefulWidget {


  String name;
  String pno;
  String rollno;
  Userprof({required this.rollno,required this.name,required this.pno});
  @override
  _UserprofState createState() => _UserprofState();
}

class _UserprofState extends State<Userprof> {
  @override
  Widget build(BuildContext context) {
    String name=widget.name;
    String pno=widget.pno;
    String rollno=widget.rollno;

    return Scaffold(
      backgroundColor: Color.fromRGBO(33, 57, 89, 1),
      body: Container(
          width: double.infinity,
          child: Container(
            child: Column(
                children: <Widget>[
                  SizedBox(height:50),
                  Text('${name}',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                  SizedBox(height: 5),
                  Row( mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Contact No.: ',
                        style: TextStyle(color: Colors.white,fontSize: 20,fontStyle: FontStyle.italic,),),
                      Text(
                        ' ${pno}',
                        style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500,),),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row( mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Interests: ',
                        style: TextStyle(color: Colors.white,fontSize: 20,fontStyle: FontStyle.italic,),),
                      Text(
                        ' ${rollno}',
                        style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500,),),
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
                              Icons.edit,
                              color: Colors.indigo[900],
                              size: 19.0,
                            ),
                            Text(
                              'Edit',
                              style: TextStyle(color: Colors.indigo[900], fontSize: 20.0),
                            ),
                          ],
                        ),
                        onPressed: (){},
                      ),
                    ],
                  ),

                ]),
          )),
    );
  }
}
