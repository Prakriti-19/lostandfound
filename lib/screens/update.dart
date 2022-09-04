// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import 'constraints.dart';
// import 'database.dart';
// import 'homeScreen.dart';
// import 'models/user.dart';
//
// class update extends StatefulWidget {
//   const update({Key? key}) : super(key: key);
//
//   @override
//   _updateState createState() => _updateState();
// }
//
// class _updateState extends State<update> {
//   String _currentName = '';
//   String gender = '';
//   String current_cc_rank = '';
//   int current_he_rank = 0;
//   int current_apk_points = 0;
//   String current_interests='';
//   String pno= '';
//
//   final _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<Usser?>(context);
//     final List<String> cc_rank = ['*', '**', '***', '****', '*****','******','*******'];
//     final List<String> interests = ['Web Development','App Development','Cyber Security','Design','Open Source','AI/ML'];
//     return Scaffold(
//         body:Container(
//             height: double.infinity,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage("images/bg.png"),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             child:SingleChildScrollView(
//                 reverse:true,
//                 child:Form(
//                     key: _formKey,
//                     child: Column(children: <Widget>[
//                       Padding(padding: EdgeInsets.only(top:30.0)),
//                       Text(
//                         'update your profile',
//                         style: TextStyle(color:Colors.white,fontSize: 35.0,fontWeight: FontWeight.bold),
//                       ),
//                       //padding: Padding()
//                       SizedBox(height: 20.0),
//                       Padding(padding: EdgeInsets.only(left: 20.0,right: 20.0),),
//                       TextFormField(
//                         decoration: textInputDecoration.copyWith(hintText: 'Your Name'),
//                         validator: (val) =>
//                         val!.isEmpty ? 'please enter your name' : null,
//                         onChanged: (val) => setState(() => _currentName = val),
//                       ),
//                       SizedBox(height: 20.0),
//                       Padding(padding: EdgeInsets.only(left: 20.0,right: 20.0),),
//                       Row(
//                         children: [
//                           Text('Male',style: TextStyle(color: Colors.white),),
//                           Radio(
//                             value: "male",
//                             groupValue: gender,
//                             onChanged: (value){
//                               setState(() {
//                                 gender = value.toString();
//                               });
//                             },
//                           ),
//                           Text('Female',style: TextStyle(color: Colors.white),),
//                           Radio(
//                             value: "female",
//                             groupValue: gender,
//                             onChanged: (value){
//                               setState(() {
//                                 gender = value.toString();
//                               });
//                             },
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 20.0),
//                       Padding(padding: EdgeInsets.only(left: 20.0,right: 20.0),),
//                       TextFormField(
//                         decoration: textInputDecoration.copyWith(hintText: 'Your contact number'),
//                         validator: (val) =>
//                         val!.isEmpty ? 'please enter your contact number' : null,
//                         onChanged: (val) => setState(() => pno= val),
//                       ),
//                       SizedBox(height: 20.0),
//                       Padding(padding: EdgeInsets.only(left: 20.0,right: 20.0),),
//                       DropdownButtonFormField(
//                           decoration: textInputDecoration.copyWith(hintText: 'Codechef Stars'),
//                           items: cc_rank.map((cc_rank) {
//                             return DropdownMenuItem(
//                               value: cc_rank,
//                               child: Text('$cc_rank stars'),
//                             );
//                           }).toList(),
//                           onChanged: (val) =>
//                               setState(() => current_cc_rank = val! as String)),
//                       SizedBox(height: 20.0),
//                       Padding(padding: EdgeInsets.only(left: 20.0,right: 20.0),),
//                       TextFormField(
//                         decoration: textInputDecoration.copyWith(hintText: 'Your HackerEarth rank'),
//                         validator: (val) =>
//                         val!.isEmpty ? 'please enter your hackerearth rank' : null,
//                         onChanged: (val) => setState(() => current_he_rank = int.parse(val)),
//                       ),
//                       SizedBox(height: 20.0),
//                       Padding(padding: EdgeInsets.only(left: 20.0,right: 20.0),),
//                       TextFormField(
//                         decoration: textInputDecoration.copyWith(hintText: 'Your Aproksha month points'),
//                         validator: (val) =>
//                         val!.isEmpty ? 'please enter your aproksha month points' : null,
//                         onChanged: (val) => setState(() => current_apk_points = int.parse(val)),
//                       ),
//                       SizedBox(height: 20.0),
//                       Padding(padding: EdgeInsets.only(left: 20.0,right: 20.0),),
//                       DropdownButtonFormField(
//                           decoration: textInputDecoration.copyWith(hintText: 'Interests'),
//                           items: interests.map((interests) {
//                             return DropdownMenuItem(
//                               value: interests,
//                               child: Text('$interests'),
//                             );
//                           }).toList(),
//                           onChanged: (val) =>
//                               setState(() => current_interests = val! as String)),
//                       SizedBox(height: 20.0),
//                       RaisedButton(
//                         color: Colors.white,
//                         child: Text(
//                           'Update',
//                           style: TextStyle(color: Colors.black, fontSize: 20.0),
//                         ),
//                         onPressed: () async{
//                           if (_formKey.currentState!.validate()) {
//                             await DatabaseService(uid: user!.uid).updateUserData(
//                               gender,
//                               _currentName ,
//                               current_cc_rank ,
//                               current_apk_points ,
//                               current_he_rank ,
//                               current_interests,
//                               pno,
//                             );
//                           }
//                           Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()),);
//                           //}
//                         },
//                       )])))
//         ));
//   }
// }
