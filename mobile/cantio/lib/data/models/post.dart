import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MusicPost {
  final String title;
  final String imageLink;
  final String audioUrl;
  final String genre;
  final Timestamp createdAt;
  int numLikes;
  Color color;
  bool isLiked;

  MusicPost({
    required this.title,
    required this.imageLink,
    required this.genre,
    required this.audioUrl,
    required this.isLiked,
    required this.createdAt,
    this.color = const Color(0xffFAFAFA),
    this.numLikes = 0,
  });

  factory MusicPost.fromMap(Map<String, dynamic> map) {
    return new MusicPost(
        title: map["name"],
        imageLink: map["imageLink"],
        audioUrl: map["fileUrl"],
        genre: map["genre"],
        createdAt: map["createdAt"],
        isLiked: false);
  }

  factory MusicPost.fromLessMap(Map<String, dynamic> map) {
    return new MusicPost(
        title: map["name"],
        imageLink: map["imageLink"],
        audioUrl: map["fileUrl"],
        genre: map["genre"],
        createdAt: Timestamp(500, 500),
        isLiked: false);
  }
}
