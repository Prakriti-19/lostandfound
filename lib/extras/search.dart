import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lostandfound/models/item.dart';
import '../listview/profiletile.dart';
import '../screens/searchscreen.dart';
import 'notfound.dart';


class search extends StatefulWidget {

  @override
  _searchState createState() => _searchState();
}

class _searchState extends State<search> {

  @override
  String interests="";

int c=0;
  Widget build(BuildContext context) {
    c=0;


    return Scaffold(
      appBar: new PreferredSize(
        child: new Container(
          padding: new EdgeInsets.only(
              top: MediaQuery.of(context).padding.top
          ),
          child: new Padding(
            padding: const EdgeInsets.only(
                left: 30.0,
                top: 20.0,
                bottom: 20.0
            ),
            child: new Text(
              'Search',
              style: new TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
              ),
            ),
          ),
          decoration: new BoxDecoration(
            color: Color.fromRGBO(92, 104, 211, .5),
          ),
        ),
        preferredSize: new Size(
            MediaQuery.of(context).size.width,
            130.0
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
            child: Container(
              height: 55,
              child: TextField(
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Color.fromRGBO(33, 57, 89, 1),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Ss(inter: interests)));
                    },
                  ),
                  fillColor:Color.fromRGBO(92, 104, 211, .3) ,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                      BorderSide.none), // OutlineInputBo
                  hintText: ' Search ',
                  hintStyle: TextStyle(
                      color: Color.fromRGBO(33, 57, 89, 1),
                      fontSize: 17),
                ),
                onChanged: (val) {
                  setState(() => interests = val);
                },
              ),
            ),
          ),

        ],
      ),
    );
  }
}