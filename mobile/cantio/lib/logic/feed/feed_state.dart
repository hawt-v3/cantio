import 'package:cantio/data/models/post.dart';
import 'package:cantio/presentation/feed/feed.dart';
import 'package:equatable/equatable.dart';

abstract class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object> get props => [];
}

class InitalFeedState extends FeedState {}

class Loading extends FeedState {}

class ObtainedFeedPosts extends FeedState {
  final List<MusicPost> musicPosts;

  ObtainedFeedPosts({required this.musicPosts});

  @override
  List<Object> get props => [musicPosts];
}

class LikedPost extends FeedState {}

class RemovedLike extends FeedState {}
