import 'package:cantio/data/models/post.dart';
import 'package:equatable/equatable.dart';

abstract class BrowseState extends Equatable {
  const BrowseState();

  @override
  List<Object> get props => [];
}

class InitalBrowseEvent extends BrowseState {}

class RetirevedSongs extends BrowseState {
  final MusicPost spotlightPost;
  final List<MusicPost> popularity;
  final List<MusicPost> pop;
  final List<MusicPost> indie;
  final List<MusicPost> hiphop;
  final List<MusicPost> metal;
  final List<MusicPost> blues;
  final List<MusicPost> rock;
  final List<MusicPost> chill;

  RetirevedSongs(
      {required this.spotlightPost,
      required this.popularity,
      required this.pop,
      required this.indie,
      required this.hiphop,
      required this.metal,
      required this.blues,
      required this.rock,
      required this.chill});

  @override
  String toString() => 'GetAllSongs';

  @override
  List<Object> get props => [spotlightPost, popularity, pop, indie, hiphop, metal, blues, rock, chill];
}
