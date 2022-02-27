import 'package:cantio/data/models/post.dart';
import 'package:cantio/data/models/user.dart';
import 'package:equatable/equatable.dart';

abstract class BrowseEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAllSongs extends BrowseEvent {}
