import 'package:cantio/data/providers/account_provider.dart';
import 'package:cantio/data/repositories/account_repository.dart';
import 'package:cantio/logic/account/account_bloc.dart';
import 'package:cantio/logic/account/account_event.dart';
import 'package:cantio/presentation/account/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountRedirect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accountRepository = new AccountRepository(accountProvider: new AccountProvider(firebaseAuth: FirebaseAuth.instance));

    return Container(
      alignment: Alignment.center,
    child: BlocProvider<AccountBloc>(
        create: (context) => AccountBloc(accountRepository)..add(GetUser()),
        child: AccountPage(),
      ),
    );
  }
}