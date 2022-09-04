import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lostandfound/models/profile.dart';
import 'package:lostandfound/models/user.dart';

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

  List<Profile> _profilelistFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Profile(
        name: doc['name'] ?? '',
        rollno: doc['rollno'] ?? '',
        pno: doc['pno'] ?? '',
        uid: '0',
        email: '0',
      );
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot['name'],
      rollno: snapshot['rollno'],
      pno: snapshot['your contact'],
    );
  }

  Stream<List<Profile>> get profile {
    return profileCollection.snapshots().map(_profilelistFromSnapshot);
  }
}
