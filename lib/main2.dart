import 'package:flutter/material.dart';
import 'package:lostandfound/models/user.dart';
import 'package:lostandfound/authenticate/wrapper.dart';
import 'package:provider/provider.dart';
import 'authenticate/auth.dart';



class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Usser?>.value(
      initialData: Usser(uid: ""),
      value: AuthService().user,
      child: MaterialApp(home: wrapper()),
    );
  }
}
