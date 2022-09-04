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
        backgroundColor: Color.fromRGBO(33, 57, 89, 1),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 50,),
              Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/mail.png"),
                      alignment: Alignment.topCenter
                  ),
                ),
              ),
              Center(
                  child: Text('WOOH HOO!', style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w500),)
              ),
              SizedBox(height: 7,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Your Mail has been sent.',
                    style: TextStyle(color: Colors.white60, fontSize: 14),),
                  Text(
                    'They will contact you ASAP for the collaboration.',
                    style: TextStyle(color: Colors.white60, fontSize: 14),)
                ],
              ),

            ]
        ));
  }
}
