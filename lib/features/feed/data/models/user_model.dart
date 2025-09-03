import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.avatarUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      name: json['name'] ?? 'Unknown',
      avatarUrl:
          json['avatar'] ??
          'https://i.pravatar.cc/150?img=${json['id'] ?? 1}', // fallback avatar
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'avatar': avatarUrl};
  }
}
