import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_app_clean_architecture/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:post_app_clean_architecture/features/posts/presentation/bloc/posts/posts_event.dart';
import 'package:post_app_clean_architecture/features/posts/presentation/bloc/posts/posts_state.dart';
import 'package:post_app_clean_architecture/features/posts/presentation/pages/post_add_update_page.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../widgets/posts_page/message_display_widget.dart';
import '../widgets/posts_page/post_list_widget.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingBtn(context),
    );
  }

  AppBar _buildAppBar() => AppBar(
        title: const Text('posts'),
      );

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
        if (state is LoadingPostsState) {
          return const LoadingWidget();
        } else if (state is LoadedPostsState) {
          return RefreshIndicator(
              onRefresh: () => _onrefresh(context),
              child: PostListWidget(posts: state.posts));
        } else if (state is ErrorPostsState) {
          return MessageDisplayWidget(message: state.message);
        }
        return const LoadingWidget();
      }),
    );
  }

  Future<void> _onrefresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreashPostsEvent());
  }

  Widget _buildFloatingBtn(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => const PostAddUpdatePage(isUpdatePost: false),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
