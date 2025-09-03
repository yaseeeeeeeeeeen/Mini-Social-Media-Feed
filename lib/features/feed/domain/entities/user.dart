import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String avatarUrl;

  const User({required this.id, required this.name, required this.avatarUrl});

  @override
  List<Object?> get props => [id, name, avatarUrl];
}
