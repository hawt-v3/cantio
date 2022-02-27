import 'package:cantio/data/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class InitalAccountState extends AccountState {}

class Loading extends AccountState {}

class UserRetrieved extends AccountState {
  final CantioUser cantioUser;

  UserRetrieved({required this.cantioUser});

  @override
  List<Object> get props => [cantioUser];
}
