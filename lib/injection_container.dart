import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:post_app_clean_architecture/core/network/network_info.dart';
import 'package:post_app_clean_architecture/features/posts/data/datasources/post_local_datasource.dart';
import 'package:post_app_clean_architecture/features/posts/data/datasources/post_remote_datasource.dart';
import 'package:post_app_clean_architecture/features/posts/data/repository/post_repository_implement.dart';
import 'package:post_app_clean_architecture/features/posts/domain/repository/post_repository.dart';
import 'package:post_app_clean_architecture/features/posts/domain/usecases/add_post.dart';
import 'package:post_app_clean_architecture/features/posts/domain/usecases/delete_post.dart';
import 'package:post_app_clean_architecture/features/posts/domain/usecases/get_all_posts.dart';
import 'package:post_app_clean_architecture/features/posts/domain/usecases/update_post.dart';
import 'package:post_app_clean_architecture/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:post_app_clean_architecture/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features -posts

  //bloc

  sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
  sl.registerFactory(
    () => AddDeleteUpdatePostBloc(
      addPost: sl(),
      deletePost: sl(),
      updatePost: sl(),
    ),
  );

  // usecases
  sl.registerLazySingleton(() => GetAllPostsUseCases(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));

  // repository

  sl.registerLazySingleton<PostsRepository>(() => PostRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  // datasources

  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImpl(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
