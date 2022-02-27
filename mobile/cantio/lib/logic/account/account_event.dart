import 'package:cantio/data/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class AccountEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetUser extends AccountEvent {
  @override
  String toString() => 'GetUser';

  @override
  List<Object> get props => [];
}
