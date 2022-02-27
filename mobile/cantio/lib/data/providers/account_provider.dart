import 'package:cantio/presentation/feed/feed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountProvider {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  AccountProvider({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  Future<Map<String, dynamic>?> getUserProfile() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection("users")
        .doc(_firebaseAuth.currentUser!.uid)
        .get();

    print("got user profile");

    return snapshot.data();
  }

  Future<List<Map<String, dynamic>>> getUserLikedSongs() async {
    List<Map<String, dynamic>> postMaps = [];

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection("users")
        .doc(_firebaseAuth.currentUser!.uid)
        .collection("likedSongs")
        .get();

    querySnapshot.docs.forEach((snapshot) {
      postMaps.add(snapshot.data());
    });

    print("got user liked songs profile");

    return postMaps;
  }
}
