import 'package:cantio/data/models/post.dart';
import 'package:cantio/presentation/feed/feed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FeedProvider {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  FeedProvider({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  Future<Map<String, dynamic>> getFeed() async {
    String uid = _firebaseAuth.currentUser!.uid;
    var uri = Uri.parse(
        "https://us-central1-cantio-3450d.cloudfunctions.net/feed?uid=${uid}");
    var response = await http.get(uri);
    Map<String, dynamic> postMaps =
        json.decode(response.body) as Map<String, dynamic>;

    print(postMaps);
    return postMaps;
  }

  Future<void> likePost(String docUid) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await firestore.collection("songs").doc(docUid).get();

    MusicPost musicPost = MusicPost.fromMap(documentSnapshot.data()!);

    await firestore
        .collection("users")
        .doc(_firebaseAuth.currentUser!.uid)
        .collection("likedSongs")
        .doc(docUid)
        .set({
      "author": {
        "init": true,
        "profilePic": "https://robohash.org/qasd",
        "username": "qoobes",
      },
      "authorId": "0x763da659725b5f450076619baf159e299d7980cf",
      "fileUrl": musicPost.audioUrl,
      "imageLink": musicPost.imageLink,
      "name": musicPost.title,
      "genre": musicPost.genre,
      "id": docUid,
    });
  }

  Future<void> removeLike(String docUid) async {
    await firestore
        .collection("users")
        .doc(_firebaseAuth.currentUser!.uid)
        .collection("likedSongs")
        .doc(docUid)
        .delete();
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    List<Map<String, dynamic>> postMaps = [];

    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firestore.collection("users").get();

    querySnapshot.docs.forEach((snapshot) {
      postMaps.add(snapshot.data());
    });

    return postMaps;
  }

  Future<List<Map<String, dynamic>>> getUserLikedSongs(String uid) async {
    List<Map<String, dynamic>> postMaps = [];

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection("users")
        .doc(uid)
        .collection("likedSongs")
        .get();

    querySnapshot.docs.forEach((snapshot) {
      postMaps.add(snapshot.data());
    });

    return postMaps;
  }

  Future<List<Map<String, dynamic>>> getSongs() async {
    List<Map<String, dynamic>> songArray = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firestore.collection("songs").get();

    querySnapshot.docs.forEach((element) {
      songArray.add(element.data());
    });

    return songArray;
  }
}
