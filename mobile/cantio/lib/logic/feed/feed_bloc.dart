import 'package:bloc/bloc.dart';
import 'package:cantio/data/repositories/feed_repository.dart';
import 'package:cantio/logic/feed/feed_event.dart';
import 'package:cantio/logic/feed/feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final FeedRepository _feedRepository;

  FeedBloc(FeedRepository feedRepository)
      : _feedRepository = feedRepository,
        super(InitalFeedState());

  @override
  Stream<FeedState> mapEventToState(FeedEvent event) async* {
    if (event is GetFeedPosts) {
      final musicPosts = await _feedRepository.getFeedPosts();
    yield ObtainedFeedPosts(musicPosts: musicPosts);
    }

    if (event is LikePost) {
      _mapLikePostToState(event);
    }

    if (event is LikePost) {
      _mapLikePostToState(event);
    }

    if (event is RemoveLike) {
      _mapRemoveLikeToState(event);
    }
  }

  Stream<FeedState> _mapLikePostToState(LikePost event) async* {
    await _feedRepository.likePost(event.docUid);
    yield LikedPost();
  }

  Stream<FeedState> _mapRemoveLikeToState(RemoveLike event) async* {
    await _feedRepository.likePost(event.docUid);
    yield LikedPost();
  }
}
