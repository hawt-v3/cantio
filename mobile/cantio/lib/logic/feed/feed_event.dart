import 'package:cantio/data/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class FeedEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetFeedPosts extends FeedEvent {
  @override
  String toString() => 'AppStarted';

  @override
  List<Object> get props => [];
}

class LikePost extends FeedEvent {
  final String docUid;

  LikePost({required this.docUid});

  @override
  String toString() => 'LikePost';

  @override
  List<Object> get props => [];
}

class RemoveLike extends FeedEvent {
  final String docUid;

  RemoveLike({required this.docUid});

  @override
  String toString() => 'RemoveLike';

  @override
  List<Object> get props => [];
}
