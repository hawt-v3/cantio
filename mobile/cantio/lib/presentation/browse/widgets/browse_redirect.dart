import 'package:cantio/data/providers/account_provider.dart';
import 'package:cantio/data/providers/browse_provider.dart';
import 'package:cantio/data/repositories/account_repository.dart';
import 'package:cantio/data/repositories/browse_repository.dart';
import 'package:cantio/logic/account/account_bloc.dart';
import 'package:cantio/logic/account/account_event.dart';
import 'package:cantio/logic/browse/browse_bloc.dart';
import 'package:cantio/logic/browse/browse_event.dart';
import 'package:cantio/presentation/account/account.dart';
import 'package:cantio/presentation/browse/browse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BrowseRedirect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final browseRepository = new BrowseRepository(browseProvider: new BrowseProvider(firebaseAuth: FirebaseAuth.instance));

    return Container(
      alignment: Alignment.center,
    child: BlocProvider<BrowseBloc>(
        create: (context) => BrowseBloc(browseRepository)..add(GetAllSongs()),
        child: BrowsePage(),
      ),
    );
  }
}