import 'package:flutter/material.dart';
import 'package:flutter_bloc_3/features/posts/bloc/posts_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  PostsBloc postsBloc = PostsBloc();

  @override
  void initState() {
    postsBloc.add(PostInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        title: Text(
          'PostPage',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<PostsBloc, PostsState>(
        bloc: postsBloc,
        listenWhen: (previous, current) => current is PostActionState,
        buildWhen: (previous, current) => current is! PostActionState,
        listener: (context, state) {
          if (state is PostAddSuccessActionState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Add Post Success')));
          } else if (state is PostAddErrorActionState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Error Post Success')));
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case PostFetchLoadingState:
              return Center(
                child: CircularProgressIndicator(),
              );
            case PostFetchSuccessState:
              final successState = state as PostFetchSuccessState;
              return ListView.builder(
                itemCount: successState.posts.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.grey[300],
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          successState.posts[index].title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(successState.posts[index].body)
                      ],
                    ),
                  );
                },
              );
            default:
              return Center(
                child: Text('Not Found'),
              );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          postsBloc.add(PostAddEvent());
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
