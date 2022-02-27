import 'package:cantio/logic/feed/feed_bloc.dart';
import 'package:cantio/logic/feed/feed_event.dart';
import 'package:cantio/logic/feed/feed_state.dart';
import 'package:cantio/presentation/extra/loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedBloc, FeedState>(
      listener: (context, state) {},
      builder: (context, state) {
        print(state);
        if (state is ObtainedFeedPosts) {
          return Feed(
            musicPosts: state.musicPosts,
          );
        }
        return LoadingPage();
      },
    );
  }
}

class Feed extends StatefulWidget with WidgetsBindingObserver {
  final musicPosts;
  const Feed({Key? key, required this.musicPosts}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  Controller controller = Controller();
  final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    startPlayingFirstSong();
    // TODO: implement initState
    super.initState();
  }

  Future<void> startPlayingFirstSong() async {
    try {
      await assetsAudioPlayer.open(
        Audio.network(widget.musicPosts[0].audioUrl),
      );
      assetsAudioPlayer.play();
    } catch (t) {
      //mp3 unreachable
    }
  }

  @override
  void dispose() {
    assetsAudioPlayer.stop();
    super.dispose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      assetsAudioPlayer.pause();
    }
  }

  void _handleCallbackEvent(ScrollEvent scrollEvent) async {
    if (scrollEvent.success == ScrollSuccess.SUCCESS) {
      try {
        await assetsAudioPlayer.open(
          Audio.network(widget.musicPosts[scrollEvent.pageNo!].audioUrl),
        );
        assetsAudioPlayer.play();
      } catch (t) {
        //mp3 unreachable
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TikTokStyleFullPageScroller(
        contentSize: widget.musicPosts.length,
        swipeVelocityThreshold: 2000,
        animationDuration: const Duration(milliseconds: 300),
        controller: controller..addListener(_handleCallbackEvent),
        builder: (BuildContext context, int index) {
          return Stack(
            children: [
              Container(
                color: widget.musicPosts[index].color,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: SizedBox(
                        height: 250,
                        width: 250,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          child:
                              Image.network(widget.musicPosts[index].imageLink),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(widget.musicPosts[index].title,
                        style: GoogleFonts.inter(fontSize: 20)),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 1,
                bottom: 10,
                child: Column(
                  children: [
                    Column(
                      children: [
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              widget.musicPosts[index].isLiked =
                                  widget.musicPosts[index].isLiked
                                      ? false
                                      : true;
                              widget.musicPosts[index].numLikes =
                                  widget.musicPosts[index].isLiked
                                      ? widget.musicPosts[index].numLikes + 1
                                      : widget.musicPosts[index].numLikes - 1;
                            });
                          },
                          child: Icon(
                            Icons.favorite,
                            color: widget.musicPosts[index].isLiked
                                ? Colors.red
                                : Colors.grey,
                            size: 40,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.musicPosts[index].numLikes.toString(),
                          style: GoogleFonts.inter(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    MaterialButton(
                      onPressed: () {},
                      child: const Icon(
                        Icons.add,
                        size: 40,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
