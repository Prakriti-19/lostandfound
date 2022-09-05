import 'package:flutter/material.dart';
import 'package:lostandfound/screens/signin.dart';
import 'package:lostandfound/extras/loading.dart';
import 'package:provider/provider.dart';
import '../authenticate/auth.dart';
import '../authenticate/database.dart';
import '../models/user.dart';
import 'homescreen.dart';


class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  String _currentName = '';
  String current_rollno = '';
  String pno= '';

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  bool loading = false;
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Usser?>(context);
    return loading
        ? Loading()
        : Scaffold(
        body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                  child: new Container(
                      color: Colors.transparent,
                      padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                      child: Form(
                          key: _formKey,
                          child: Column(children: <Widget>[
                            SizedBox(height: 30.0),
                            Text('IIIT ALLAHABAD',style: TextStyle(color: Color.fromRGBO(12,65,96,0.3),fontWeight: FontWeight.bold,fontSize: 23),),
                            SizedBox(height: 4.0),
                            Text(' LOST AND \n    FOUND',style: TextStyle(color: Color.fromRGBO(12,65,96,1),fontWeight: FontWeight.bold,fontSize: 45),),
                            SizedBox(height: 8.0),
                            Text('SIGNUP',style: TextStyle(color: Color.fromRGBO(12,65,96,0.7),fontWeight: FontWeight.bold,fontSize: 27),),
                            SizedBox(height: 10.0),
                            TextFormField(
                              decoration: InputDecoration(
                                  hintText: 'Email'),
                              validator: (val) =>
                              val!.isEmpty ? 'Email' : null,
                              onChanged: (val) {
                                setState(() => email = val);
                              },
                            ),
                            SizedBox(height: 15.0),
                            TextFormField(
                              decoration: InputDecoration(
                                  hintText: 'Password'),
                              obscureText: true,
                              validator: (value) => value!.length < 6
                                  ? 'Enter a password of 6 or more characters'
                                  : null,
                              onChanged: (val) {
                                setState(() => password = val);
                              },
                            ),
                            SizedBox(height: 15.0),
                            TextFormField(
                              decoration: InputDecoration(
                                  hintText: 'Name'),
                              validator: (val) =>
                              val!.isEmpty ? 'Name' : null,
                              onChanged: (val) => setState(() => _currentName = val),
                            ),
                            SizedBox(height: 15.0),
                            Padding(padding: EdgeInsets.only(left: 20.0,right: 20.0),),
                            TextFormField(
                              decoration: InputDecoration(
                                  hintText: 'Contact Number'),
                              validator: (val) =>
                              val!.isEmpty ? 'Contact Number' : null,
                              onChanged: (val) => setState(() => pno= val),
                            ),
                            SizedBox(height: 15.0),
                            Padding(padding: EdgeInsets.only(left: 20.0,right: 20.0),),
                            TextFormField(
                              decoration: InputDecoration(
                                  hintText: 'Roll Number'),
                              validator: (val) =>
                              val!.isEmpty ? 'Roll Number' : null,
                              onChanged: (val) => setState(() => current_rollno = val),
                            ),
                            SizedBox(height: 10.0),
                            Container(
                              padding: EdgeInsets.fromLTRB(40, 20,40, 0),
                              width: double.infinity,
                              child: RaisedButton(
                                  padding: EdgeInsets.all(15),
                                  color: Color.fromRGBO(12,65,96,1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32)),
                                  child: Text(
                                    'Register',
                                    style: TextStyle(fontSize: 18,
                                        fontFamily: 'Mochiy Pop P One',
                                        color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      dynamic result =
                                      await _auth.registerWithEmailAndPassword(
                                          email, password);
                                      await DatabaseService(uid: user!.uid).updateUserData(
                                        _currentName ,
                                        current_rollno,
                                        pno,
                                      );
                                      if (result == null) {
                                        setState(() {
                                          error = 'please supply a valid email';
                                          loading = false;
                                        });
                                      } else
                                        {
                                          await DatabaseService(uid: user!.uid).updateUserData(
                                        _currentName ,
                                        current_rollno,
                                        pno,
                                        );
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>HomeScreen()),
                                        );
                                    }}
                                  }),
                            ),
                            Text(
                              error,
                              style: TextStyle(color: Colors.black, fontSize: 8.0),
                            ),
                            Row(
                              children: [
                                SizedBox(width: 45,),
                                Text("Already have an account?",style: TextStyle(color: Color.fromRGBO(12,65,96,0.3),fontWeight: FontWeight.normal)),
                                TextButton(onPressed:() => Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => signIn()),
                                ), child: Text("Sign In",style: TextStyle(color: Color.fromRGBO(12,65,96,0.6),fontWeight: FontWeight.bold)
                                  ,))
                              ],
                            ),
                          ])))
              )]));
  }
}
