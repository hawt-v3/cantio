import 'package:cantio/data/models/post.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class PostDetail extends StatefulWidget with WidgetsBindingObserver {
  final MusicPost post;
  const PostDetail({Key? key, required this.post}) : super(key: key);

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
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
        Audio.network(widget.post.audioUrl),
      );
      assetsAudioPlayer.play();
    } catch (t) {
      //mp3 unreachable
    }
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      assetsAudioPlayer.pause();
    }
  }

  @override
  void dispose() {
    assetsAudioPlayer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Color(0xffFAFAFA),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Material(
                      type: MaterialType.transparency,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 175,
              ),
              Center(
                child: SizedBox(
                  height: 250,
                  width: 250,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Image.network(widget.post.imageLink),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(widget.post.title, style: GoogleFonts.inter(fontSize: 20, color: Colors.white, decoration: TextDecoration.none)),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
