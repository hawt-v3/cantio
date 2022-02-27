import 'package:cantio/data/providers/auth_provider.dart';
import 'package:cantio/logic/auth/auth_bloc.dart';
import 'package:cantio/logic/auth/auth_event.dart';
import 'package:cantio/logic/auth/auth_state.dart';
import 'package:cantio/presentation/extra/loading.dart';
import 'package:cantio/presentation/home/home.dart';
import 'package:cantio/presentation/landing/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(BlocProvider(
    create: (context) =>
        AuthBloc(AuthProvider(firebaseAuth: FirebaseAuth.instance))
          ..add(AppStarted()),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cantio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        if (state is Unauthenticated) {
          return const LandingPage();
        } else if (state is Authenticated) {
          return Home();
        } else {
          return const LoadingPage();
        }
      }),
      debugShowCheckedModeBanner: false,
    );
  }
}
