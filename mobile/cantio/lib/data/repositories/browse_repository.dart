import 'package:cantio/data/models/post.dart';
import 'package:cantio/data/providers/browse_provider.dart';

class BrowseRepository {
  final BrowseProvider _browseProvider;

  BrowseRepository({
    required BrowseProvider browseProvider,
  }) : _browseProvider = browseProvider;

  Future<MusicPost> getSpotlightSong() async {
    Map<String, dynamic> spotlightMap = await _browseProvider.getSpotlight();

    return MusicPost.fromMap(spotlightMap);
  }

  Future<List<MusicPost>> getSongByGenre(String genre) async {
    List<Map<String, dynamic>> genreMap =
        await _browseProvider.getByGenre(genre);

    List<MusicPost> posts = [];

    genreMap.forEach((element) {
      posts.add(MusicPost.fromMap(element));
    });

    return posts;
  }

  Future<List<MusicPost>> getMostPopular() async {
    List<Map<String, dynamic>> popularityMap =
        await _browseProvider.getMostPopular();

    List<MusicPost> posts = [];

    popularityMap.forEach((element) {
      posts.add(MusicPost.fromMap(element));
    });

    return posts;
  }
}
