import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

final _random = new Random();

class BrowseProvider {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  BrowseProvider({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  Future<Map<String, dynamic>> getSpotlight() async {
    List<Map<String, dynamic>> songArray = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firestore.collection("songs").get();

    querySnapshot.docs.forEach((element) {
      songArray.add(element.data());
    });

    return songArray[_random.nextInt(songArray.length)];
  }

  Future<List<Map<String, dynamic>>> getByGenre(String genre) async {
    List<Map<String, dynamic>> songArray = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firestore.collection("songs").get();

    querySnapshot.docs.forEach((element) {
      if (element.data()["genre"] == genre) {
        songArray.add(element.data());
      }
    });

    return songArray;
  }

  Future<List<Map<String, dynamic>>> getMostPopular() async {
    List<Map<String, dynamic>> songArray = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firestore.collection("songs").get();

    querySnapshot.docs.forEach((element) {
      songArray.add(element.data());
    });

    return songArray;
  }
}
