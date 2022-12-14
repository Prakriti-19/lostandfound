import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Flash extends StatefulWidget {
  @override
  _FlashState createState() => _FlashState();
}

class _FlashState extends State<Flash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 50,),
              Container(
                height: 300,
                width: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/retry.png"),
                      alignment: Alignment.topCenter
                  ),
                ),
              ),
              Center(
                  child: Text('SORRY',style: TextStyle(color: Color.fromRGBO(12,65,96,.9),fontSize: 40,fontWeight: FontWeight.w500),)
              ),
              SizedBox(height: 7,),
              Center(
                  child: Text('No match found.',style: TextStyle(color: Color.fromRGBO(12,65,96,.7),fontSize: 16),)
              ),

            ]
        ));
  }
}