import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/feed_bloc.dart';
import '../bloc/feed_event.dart';
import '../bloc/feed_state.dart';

class CommentSheet extends StatefulWidget {
  final String postId;
  const CommentSheet({super.key, required this.postId});

  @override
  State<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<FeedBloc>().add(CommentsRequested(widget.postId));
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      maxChildSize: 0.95,
      minChildSize: 0.4,
      builder: (context, scrollController) {
        return BlocBuilder<FeedBloc, FeedState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Container(
                    height: 4,
                    width: 40,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      children: [
                        if (state is CommentsLoaded &&
                            state.postId == widget.postId)
                          ...state.comments.map(
                            (c) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(c.user.avatarUrl),
                              ),
                              title: Text(
                                c.user.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(c.text),
                            ),
                          ),
                        if (state is! CommentsLoaded)
                          const Center(child: CircularProgressIndicator()),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: "Add a comment...",
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send, color: Colors.indigo),
                        onPressed: () {
                          if (_controller.text.isNotEmpty) {
                            context.read<FeedBloc>().add(
                              CommentAdded(widget.postId, _controller.text),
                            );
                            _controller.clear();
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
