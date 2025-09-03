import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/feed_bloc.dart';
import '../bloc/feed_event.dart';
import '../bloc/feed_state.dart';
import '../widgets/post_item.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final ScrollController _scrollController = ScrollController();
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<FeedBloc>().add(FeedFetched(page: _page));
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _page++;
      context.read<FeedBloc>().add(FeedFetched(page: _page));
    }
  }

  Future<void> _onRefresh() async {
    _page = 1;
    context.read<FeedBloc>().add(FeedFetched(page: _page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mini Social Feed")),
      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          if (state is FeedLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FeedLoaded) {
            if (state.posts.isEmpty) {
              return const Center(child: Text("No posts yet"));
            }
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  return PostItem(post: state.posts[index]);
                },
              ),
            );
          } else if (state is FeedError) {
            return Center(child: Text("Error: ${state.message}"));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
