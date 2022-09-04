import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lostandfound/authenticate/database.dart';
import 'package:lostandfound/models/user.dart';
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Usser? _userFormFirebaseUser(User? user) {
    return user != null ? Usser(uid: user.uid) : null;
  }
  Stream<Usser?> get user {
    return _auth.authStateChanges().map( _userFormFirebaseUser );
  }

  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result=await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user=result.user;
      await DatabaseService(uid: user!.uid).updateUserData('newTeammate','----------','0000000000');
      return _userFormFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user=result.user;
      FirebaseFirestore.instance.collection("users").doc(user?.uid).set({
        "uid": user?.uid,});
      await DatabaseService(uid: user!.uid).updateUserData('newTeammate','----------','0000000000');
      return _userFormFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  Future signOut() async {
    try {
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}