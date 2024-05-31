import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post_model.dart';

class PostsRepos {
  static Future<List<PostModel>> fetchPost() async {
    List<PostModel> posts = [];
    try {
      var response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      if (response.statusCode == 200) {
        // Giải mã dữ liệu JSON và chuyển đổi nó thành danh sách các đối tượng PostModel
        var data = json.decode(response.body) as List;
        posts = data.map((postJson) => PostModel.fromJson(postJson)).toList();
      } else {
        print('Failed to load posts: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error occurred: $e');
      return [];
    }
    return posts;
  }

  static Future<bool> addPost() async {
    try {
      var request = http.Request(
          'POST', Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      request.body = json.encode(
          {"userId": "100", "id": "100", "title": "test", "body": "test"});

      http.StreamedResponse response = await request.send();
      print(response.statusCode);

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error occurred: $e');
    }
    return false;
  }
}
