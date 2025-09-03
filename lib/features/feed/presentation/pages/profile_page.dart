import 'package:flutter/material.dart';
import 'package:mini_social_media/features/feed/domain/entities/user.dart';


class ProfilePage extends StatelessWidget {
  final User user;

  const ProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.avatarUrl),
            ),
            const SizedBox(height: 16),
            Text(
              user.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "User ID: ${user.id}",
              style: const TextStyle(color: Colors.grey),
            ),
            const Divider(height: 32),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "About",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "This is a demo profile. You could expand this to show user's posts, bio, followers, etc.",
              style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }
}
