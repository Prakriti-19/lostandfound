import 'package:flutter/material.dart';
import 'package:lostandfound/screens/register.dart';
import 'package:lostandfound/screens/signin.dart';
class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}
class _AuthenticateState extends State<Authenticate> {
  bool showsSignIn = true;
  void toggleView()  {
    setState(() => showsSignIn =!showsSignIn);
  }
  @override
  Widget build(BuildContext context) {
    if(showsSignIn) {
      return signIn();
    } else {
      return Register();
    }
    //return Scaffold();
  }
}