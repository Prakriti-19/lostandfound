import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  final CollectionReference profileCollection =
  FirebaseFirestore.instance.collection('profile');

  Future<void> updateUserData(String name,  String rollno, String pno) async {
    return await profileCollection.doc(uid).set({
      'name': name,
      'rollno': rollno,
      'pno': pno,
    });
  }
 }
