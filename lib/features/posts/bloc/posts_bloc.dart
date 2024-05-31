import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_3/features/posts/models/post_model.dart';
import 'package:flutter_bloc_3/features/posts/repos/posts_repos.dart';
import 'package:meta/meta.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostInitialFetchEvent>(postInitialFetchEvent);
    on<PostAddEvent>(postAddEvent);
  }

  FutureOr<void> postInitialFetchEvent(
      PostInitialFetchEvent event, Emitter<PostsState> emit) async {
    emit(PostFetchLoadingState());
    List<PostModel> posts = await PostsRepos.fetchPost();
    emit(PostFetchSuccessState(posts: posts));
  }

  FutureOr<void> postAddEvent(
      PostAddEvent event, Emitter<PostsState> emit) async {
    bool success = await PostsRepos.addPost();
    if(success) {
      emit(PostAddSuccessActionState());
    } else {
      emit(PostAddErrorActionState());
    }
  }
}
