import 'package:cantio/data/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {
  @override
  String toString() => 'AppStarted';

  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthEvent {
  final CantioUser? user;

  LoggedIn({required this.user});

  @override
  List<Object> get props => [user!];
}

class LoggedOut extends AuthEvent {}
