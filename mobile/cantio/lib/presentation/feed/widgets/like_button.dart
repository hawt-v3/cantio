import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LikeButton extends StatefulWidget {
  bool isLiked;
  int numLikes;
  LikeButton({Key? key, required this.isLiked, required this.numLikes})
      : super(key: key);

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
      ],
    );
  }
}
