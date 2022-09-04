import 'package:flutter/material.dart';
import 'package:lostandfound/screens/register.dart';
import 'package:lostandfound/models/user.dart';
import 'package:provider/provider.dart';
import '../screens/homescreen.dart';

class wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Usser?>(context);
    if(user==null){
      return Register(); //not signed in->welcome->login/sign in
    }
    else{
      return HomeScreen();//call home screen
    }
  }
}
