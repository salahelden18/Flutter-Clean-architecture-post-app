import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_app_clean_architecture/core/error/failures.dart';
import 'package:post_app_clean_architecture/core/strings/failures.dart';
import 'package:post_app_clean_architecture/features/posts/domain/usecases/get_all_posts.dart';
import 'package:post_app_clean_architecture/features/posts/presentation/bloc/posts/posts_event.dart';
import 'package:post_app_clean_architecture/features/posts/presentation/bloc/posts/posts_state.dart';

import '../../../domain/entities/post.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCases getAllPosts;

  PostsBloc({required this.getAllPosts}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());

        final failureOrPosts = await getAllPosts.call();
        emit(_mapFailureOrPostsToState(failureOrPosts));
      } else if (event is RefreashPostsEvent) {
        emit(LoadingPostsState());

        final failureOrPosts = await getAllPosts.call();
        emit(_mapFailureOrPostsToState(failureOrPosts));
      }
    });
  }

  PostsState _mapFailureOrPostsToState(Either<Failure, List<Post>> either) {
    return either.fold(
      (failure) => ErrorPostsState(message: _mapFailureToMessage(failure)),
      (posts) => LoadedPostsState(posts: posts),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;

      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error, Please try again later.';
    }
  }
}
