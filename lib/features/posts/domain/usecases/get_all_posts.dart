import 'package:dartz/dartz.dart';
import 'package:post_app_clean_architecture/core/error/failures.dart';
import 'package:post_app_clean_architecture/features/posts/domain/entities/post.dart';
import 'package:post_app_clean_architecture/features/posts/domain/repository/post_repository.dart';

class GetAllPostsUseCases {
  final PostsRepository repository;

  GetAllPostsUseCases(this.repository);

  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getAllPosts();
  }
}
