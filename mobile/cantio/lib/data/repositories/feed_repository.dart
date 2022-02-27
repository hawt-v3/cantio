import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cantio/data/models/post.dart';
import 'package:cantio/data/models/user.dart';
import 'package:cantio/data/providers/account_provider.dart';
import 'package:cantio/data/providers/feed_provider.dart';
import 'package:palette_generator/palette_generator.dart';

class FeedRepository {
  final FeedProvider _feedProvider;

  FeedRepository({
    required FeedProvider feedProvider,
  }) : _feedProvider = feedProvider;

  Future<List<MusicPost>> getFeedPosts() async {
    Map<String, dynamic> map = await _feedProvider.getFeed();
    var postMaps = map["songs"];

    List<MusicPost> musicPosts = List<MusicPost>.from(
        postMaps.map((model) => MusicPost.fromLessMap(model)));

    List<Map<String, dynamic>> maps = await _feedProvider.getUsers();

    List<Map<String, dynamic>> allLikedSongs = [];

    for (Map<String, dynamic> map in maps) {
      print(map);
      List<Map<String, dynamic>> likedMaps =
          await _feedProvider.getUserLikedSongs(map["key"]);
      likedMaps.forEach((element) {
        allLikedSongs.add(element);
      });
    }

    for (MusicPost post in musicPosts) {
      post.color = await getMainColor(NetworkImage(post.imageLink));
      for (Map<String, dynamic> allLikedMap in allLikedSongs) {
        if (post.title == allLikedMap["name"]) {
          post.numLikes++;
        }
      }
    }
    return musicPosts;
  }

  Future<void> likePost(String uid) async {
    await _feedProvider.likePost(uid);
  }

  Future<void> removeLike(String docUid) async {
    await _feedProvider.removeLike(docUid);
  }

  Future<Color> getMainColor(ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor!.color;
  }

  Future<List<MusicPost>> getSongs() async {
    List<Map<String, dynamic>> popularityMap =
        await _feedProvider.getSongs();

    List<MusicPost> posts = [];

    popularityMap.forEach((element) {
      posts.add(MusicPost.fromMap(element));
    });

    return posts;
  }
}
