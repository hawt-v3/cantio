import 'package:cantio/data/models/post.dart';
import 'package:flutter/material.dart';
import 'package:cantio/presentation/detail/post_detail.dart';

class SongCard extends StatelessWidget {
  final MusicPost post;
  const SongCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostDetail(post: post,)),
          );
        },
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
          child: Image.network(post.imageLink),
        ),
      ),
    );
  }
}
