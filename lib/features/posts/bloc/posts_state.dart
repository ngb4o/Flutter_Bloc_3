part of 'posts_bloc.dart';

@immutable
sealed class PostsState {}

final class PostsInitial extends PostsState {}

abstract class PostActionState extends PostsState{}

class PostFetchLoadingState extends PostsState {}

class PostFetchSuccessState extends PostsState {
  final List<PostModel> posts;

  PostFetchSuccessState({required this.posts});
}

class PostFetchErrorState extends PostsState {}

class PostAddSuccessActionState extends PostActionState {}

class PostAddErrorActionState extends PostActionState{}
