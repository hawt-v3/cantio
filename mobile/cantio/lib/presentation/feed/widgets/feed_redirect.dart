import 'package:cantio/data/providers/feed_provider.dart';
import 'package:cantio/data/repositories/feed_repository.dart';
import 'package:cantio/logic/feed/feed_bloc.dart';
import 'package:cantio/logic/feed/feed_event.dart';
import 'package:cantio/presentation/feed/feed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FeedRedirect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final feedRepostory = new FeedRepository(feedProvider: new FeedProvider(firebaseAuth: FirebaseAuth.instance));

    return Container(
      alignment: Alignment.center,
    child: BlocProvider<FeedBloc>(
        create: (context) => FeedBloc(feedRepostory)..add(GetFeedPosts()),
        child: FeedPage(),
      ),
    );
  }
}