import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AuthProvider {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  AuthProvider({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;


  Future<User?> registerUser({
    required String email,
    required String password,
  }) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    User? user = userCredential.user;
    users.doc(user!.uid).set({
      "init" : true,
      "key": user.uid,
      "username" : user.email,
      "profilePic" : "https://robohash.org/" + user.uid,
      });

    return userCredential.user;
  }

  Future<User?> login({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  Future<User?> getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }
}
