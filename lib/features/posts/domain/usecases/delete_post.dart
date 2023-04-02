import 'package:dartz/dartz.dart';
import 'package:post_app_clean_architecture/features/posts/domain/repository/post_repository.dart';

import '../../../../core/error/failures.dart';

class DeletePostUseCase {
  final PostsRepository repository;

  DeletePostUseCase(this.repository);

  Future<Either<Failure, Unit>> call(int postId) async {
    return await repository.deletePost(postId);
  }
}
