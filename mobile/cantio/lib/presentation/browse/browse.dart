import 'package:cantio/data/models/post.dart';
import 'package:cantio/logic/browse/browse_bloc.dart';
import 'package:cantio/logic/browse/browse_state.dart';
import 'package:cantio/presentation/browse/widgets/song_card.dart';
import 'package:cantio/presentation/extra/loading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrowsePage extends StatelessWidget {
  const BrowsePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BrowseBloc, BrowseState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is RetirevedSongs) {
          return Browse(
              spotlightPost: state.spotlightPost,
              popularity: state.popularity,
              pop: state.pop,
              indie: state.indie,
              hiphop: state.hiphop,
              metal: state.metal,
              blues: state.blues,
              rock: state.rock,
              chill: state.chill);
        }
        return LoadingPage();
      },
    );
  }
}

class Browse extends StatefulWidget {
  final MusicPost spotlightPost;
  final List<MusicPost> popularity;
  final List<MusicPost> pop;
  final List<MusicPost> indie;
  final List<MusicPost> hiphop;
  final List<MusicPost> metal;
  final List<MusicPost> blues;
  final List<MusicPost> rock;
  final List<MusicPost> chill;
  const Browse(
      {Key? key,
      required this.spotlightPost,
      required this.popularity,
      required this.pop,
      required this.indie,
      required this.hiphop,
      required this.metal,
      required this.blues,
      required this.rock,
      required this.chill})
      : super(key: key);

  @override
  _BrowseState createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0, left: 30),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Discover New Music",
                        style: GoogleFonts.inter(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Spotlight",
                            style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            widget.spotlightPost.title.split("-")[0],
                            style: GoogleFonts.inter(
                              fontSize: 15,
                            ),
                          ),
                          // Text(
                          //   "By:" + widget.spotlightPost.title.split("-")[1],
                          //   style: GoogleFonts.inter(
                          //     fontSize: 15,
                          //   ),
                          // )
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        height: 135,
                        width: 135,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15.0)),
                          child: Image.network(
                              widget.spotlightPost.imageLink),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Most Popular",
                      style: GoogleFonts.inter(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                widget.popularity.length == 0 ? Text("No available songs in this genre") : Container(
                  height: 135,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.popularity.length,
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {
                        return SongCard(
                          post: widget.popularity[index]
                        );
                      })),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Pop",
                      style: GoogleFonts.inter(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                widget.pop.length == 0 ? Text("No available songs in this genre") : Container(
                  height: 135,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.pop.length,
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {
                        return SongCard(
                          post: widget.pop[index],
                        );
                      })),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Indie",
                      style: GoogleFonts.inter(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                widget.indie.length == 0 ? Text("No available songs in this genre") : Container(
                  height: 135,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.indie.length,
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {
                        return SongCard(
                          post: widget.indie[index],
                        );
                      })),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Hip Hop",
                      style: GoogleFonts.inter(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                widget.hiphop.length == 0 ? Text("No available songs in this genre") : Container(
                  height: 135,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.hiphop.length,
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {
                        return SongCard(
                          post: widget.hiphop[index],
                        );
                      })),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Metal",
                      style: GoogleFonts.inter(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                widget.metal.length == 0 ? Text("No available songs in this genre") : Container(
                  height: 135,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.metal.length,
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {
                        return SongCard(
                          post: widget.metal[index],
                        );
                      })),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Blues",
                      style: GoogleFonts.inter(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                widget.blues.length == 0 ? Text("No available songs in this genre") : Container(
                  height: 135,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.blues.length,
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {
                        return SongCard(
                          post: widget.blues[index],
                        );
                      })),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Rock",
                      style: GoogleFonts.inter(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                widget.rock.length == 0 ? Text("No available songs in this genre") : Container(
                  height: 135,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.rock.length,
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {
                        return SongCard(
                          post: widget.rock[index],
                        );
                      })),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Chill",
                      style: GoogleFonts.inter(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                widget.chill.length == 0 ? Text("No available songs in this genre") : Container(
                  height: 135,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.chill.length,
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {
                        return SongCard(
                          post: widget.chill[index],
                        );
                      })),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
