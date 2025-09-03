import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_social_media/features/feed/domain/entities/post.dart';
import 'package:mini_social_media/features/feed/presentation/widgets/video_player_widget.dart';

import '../bloc/feed_bloc.dart';
import '../bloc/feed_event.dart';
import 'comment_sheet.dart';

class PostItem extends StatelessWidget {
  final Post post;

  const PostItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          ListTile(
            leading: CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(post.user.avatarUrl),
            ),
            title: Text(
              post.user.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "${post.createdAt.hour}:${post.createdAt.minute} • ${post.createdAt.day}/${post.createdAt.month}",
            ),
            onTap: () {
              // TODO: navigate to profile
            },
          ),

          // Content
          if (post.content.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                post.content,
                style: const TextStyle(fontSize: 15, height: 1.3),
              ),
            ),

          // Media
          if (post.mediaUrl != null)
            post.isVideo
                ? VideoPlayerWidget(url: post.mediaUrl!)
                : CachedNetworkImage(
                  imageUrl: post.mediaUrl!,
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) => Container(
                        height: 200,
                        color: Colors.grey.shade300,
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                ),


          // Actions row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    post.isLiked ? Icons.favorite : Icons.favorite_border,
                    color: post.isLiked ? Colors.red : null,
                    size: 28,
                  ),
                  onPressed: () {
                    context.read<FeedBloc>().add(PostLiked(post.id));
                  },
                ),
                Text("${post.likes}"),

                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.mode_comment_outlined, size: 26),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (_) => CommentSheet(postId: post.id),
                    );
                  },
                ),
                Text("${post.comments.length}"),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
