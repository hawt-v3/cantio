import 'package:cantio/data/models/post.dart';

class CantioUser {
  final String username;
  final String profilePic;
  final String key;
  final List<MusicPost> likedSongs;
  final int totalLikes;

  CantioUser({
    required this.username,
    required this.profilePic,
    required this.key,
    required this.likedSongs,
    required this.totalLikes,
  });

  factory CantioUser.fromMap(
      Map<String, dynamic> map, List<MusicPost> likedPosts) {
    return new CantioUser(
      username: map["username"],
      profilePic: map["profilePic"],
      key: map["key"],
      likedSongs: likedPosts,
      totalLikes: likedPosts.length,
    );
  }
}
