import 'package:cantio/data/models/post.dart';
import 'package:cantio/data/models/user.dart';
import 'package:cantio/data/providers/account_provider.dart';

class AccountRepository {
  final AccountProvider _accountProvider;

  AccountRepository({
    required AccountProvider accountProvider,
  }) : _accountProvider = accountProvider;

  Future<CantioUser> getProfile() async {
    Map<String, dynamic>? map = await _accountProvider.getUserProfile();

    List<MusicPost> musicPosts = [];
    List<Map<String, dynamic>> maps =
        await _accountProvider.getUserLikedSongs();

    for (Map<String, dynamic> map in maps) {
      musicPosts.add(MusicPost.fromMap(map));
    }
    print("here");

    return CantioUser.fromMap(map!, musicPosts);
  }
}
