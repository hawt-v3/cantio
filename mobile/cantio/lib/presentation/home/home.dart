import 'package:cantio/presentation/account/account.dart';
import 'package:cantio/presentation/account/widgets/account_redirect.dart';
import 'package:cantio/presentation/browse/browse.dart';
import 'package:cantio/presentation/browse/widgets/browse_redirect.dart';
import 'package:cantio/presentation/feed/feed.dart';
import 'package:cantio/presentation/feed/widgets/feed_redirect.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> pages = [
    FeedRedirect(),
    BrowseRedirect(),
    AccountRedirect(),
  ];

  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: CurvedNavigationBar(
        items: const <Widget>[
          Icon(
            Icons.feed_outlined,
          ),
          Icon(
            Icons.preview_outlined,
          ),
          Icon(
            Icons.person_outlined,
          ),
        ],
        backgroundColor: const Color(0x00ffffff),
        color: Colors.white,
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
    );
  }
}
