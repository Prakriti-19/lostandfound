import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lostandfound/screens/userprofile.dart';
import '../authenticate/auth.dart';
import '../screens/delete.dart';
import 'itemadd.dart';


class mDrawer extends StatefulWidget {
  final User user;
  const mDrawer({
    required this.user,
  });
  @override
  State<mDrawer> createState() => _mDrawerState();
}

class _mDrawerState extends State<mDrawer> {
  late User _currentUser;
  final AuthService _auth = AuthService();
  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  List<String> profileName= [];
  List<String> profilepno=[];
  List<String> profilroll=[];

  int c = 0;

  Drawer build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('profile')
        .doc(_currentUser.uid)
        .update({'uid': _currentUser.uid});
    FirebaseFirestore.instance
        .collection('profile')
        .doc(_currentUser.uid)
        .update({'email': _currentUser.email});
    int c = 0;
    final Stream<QuerySnapshot> _usersStream =
    FirebaseFirestore.instance.collection('profile').snapshots();
    _usersStream.forEach((profile) {
      profile.docs.asMap().forEach((index, data) {
        if ((profile.docs[index]['uid']).toString() ==
            (_currentUser.uid).toString()) {
          profileName.add(profile.docs[index]['name']);
          print(profileName[0]);
        }
      });
    });
    _usersStream.forEach((profile) {
      profile.docs.asMap().forEach((index, data) {
        if ((profile.docs[index]['uid']).toString() ==
            (_currentUser.uid).toString()) {
          profilroll.add(profile.docs[index]['rollno']);
          print(profilroll[0]);
        }
      });
    });
    _usersStream.forEach((profile) {
      profile.docs.asMap().forEach((index, data) {
        if ((profile.docs[index]['uid']).toString() ==
            (_currentUser.uid).toString()) {
          profilepno.add(profile.docs[index]['pno']);
          print(profilepno[0]);
        }
      });
    });
    return Drawer(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      backgroundColor: Colors.white,
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('profile').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return
              ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/welcome.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Text(''),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.account_circle_rounded,
                    ),
                    title: const Text('My Profile'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Userprof( name: profileName[0], rollno: profilroll[0].toString(), pno: profilepno[0],)),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.history,
                    ),
                    title: const Text('History'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => delete(id: _currentUser.uid,)));
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.add_circle_rounded,
                    ),
                    title: const Text('Add item'),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => P_list( name: profileName[0], uid: _currentUser.uid)));
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.search,
                    ),
                    title: const Text('Search'),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => search(interests: '',)),
                      // );
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.logout,
                    ),
                    title: const Text('Logout'),
                    onTap: () async  {
                      await _auth.signOut();
                    },
                  ),
                ],
              );
            //}
            // }
          }),
    );
  }
}
