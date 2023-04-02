import 'package:equatable/equatable.dart';
import 'package:post_app_clean_architecture/features/posts/domain/entities/post.dart';

abstract class AddDeleteUpdateState extends Equatable {
  const AddDeleteUpdateState();

  @override
  List<Object> get props => [];
}

class AddDeleteUpdatePostInitial extends AddDeleteUpdateState {}

class LoadingAddDeleteUpdatePostState extends AddDeleteUpdateState {}

class ErrorAddDeleteUpdatePostState extends AddDeleteUpdateState {
  final String message;

  const ErrorAddDeleteUpdatePostState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageAddDeleteUpdatePostState extends AddDeleteUpdateState {
  final String message;

  const MessageAddDeleteUpdatePostState({required this.message});

  @override
  List<Object> get props => [message];
}
