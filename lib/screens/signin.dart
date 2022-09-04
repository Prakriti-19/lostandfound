import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:lostandfound/screens/register.dart';
import 'package:lostandfound/extras/loading.dart';
import 'homescreen.dart';


class signIn extends StatefulWidget {
  // final Function toggleView;
  // signIn({required this.toggleView});
  @override
  _signInState createState() => _signInState();
}

class _signInState extends State<signIn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  bool loading = false;
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
        body:
        Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: new Container(
                  padding:
                  EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
                  color: Colors.transparent,
                  child: Form(
                      key: _formKey,
                      child: Column(children: <Widget>[
                        SizedBox(height: 30.0),
                        Text('IIIT ALLAHABAD',style: TextStyle(color: Color.fromRGBO(12,65,96,.3),fontWeight: FontWeight.bold,fontSize: 23),),
                        SizedBox(height: 4.0),
                        Text(' LOST AND \n   FOUND',style: TextStyle(color: Color.fromRGBO(12,65,96,1),fontWeight: FontWeight.bold,fontSize: 45),),
                        SizedBox(height: 60.0),
                        Text('SIGNIN',style: TextStyle(color: Color.fromRGBO(12,65,96,.6),fontWeight: FontWeight.bold,fontSize: 27),),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Email'),
                          validator: (val) =>
                          val!.isEmpty ? 'Enter an email' : null,
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
                        SizedBox(height: 10.0),
                        Container(
                          padding: EdgeInsets.fromLTRB(35, 25,35, 0),
                          width: double.infinity,
                          child: RaisedButton(
                              padding: EdgeInsets.all(15),
                              color: Color.fromRGBO(12,65,96,1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32)),
                              child: Text(
                                'Sign In',
                                style: TextStyle(fontFamily: 'Mochiy Pop P One',color: Colors.white,fontSize: 18),
                              ),
                              onPressed: ()
                              async {
                                // if (_formKey.currentState!.validate()) {
                                //   //setState(() => loading = true);
                                //   dynamic result =
                                //   await _auth.signInWithEmailAndPassword(email:
                                //   email, password: password);
                                //   if (result == null) {
                                //     setState(() {
                                //       error = 'please supply a valid email';
                                //       loading = false;
                                //     });
                                //   } else
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()),
                                    );
                               // }
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => HomeScreen()),
                                // );
                              }),
                        ),
                        Text(
                          error,
                          style: TextStyle(color: Colors.black, fontSize: 14.0),
                        ),
                        Row(
                          children: [
                            SizedBox(width: 45,),
                            Text("Don't have an account?",style: TextStyle(color: Color.fromRGBO(12,65,96,0.3),fontWeight: FontWeight.normal)),
                            TextButton(onPressed:() => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Register()),
                            ), child: Text("Register",style: TextStyle(color: Color.fromRGBO(12,65,96,0.6),fontWeight: FontWeight.bold)
                              ,))
                          ],
                        ),

                      ])),
                ),
              ),
            ]));

  }
}
