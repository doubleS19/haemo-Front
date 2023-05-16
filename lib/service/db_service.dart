import 'dart:convert';
import 'dart:ffi';
import 'package:get/get.dart';
import 'package:hae_mo/model/post_model.dart';
import 'package:hae_mo/model/post_response_model.dart' as prefix;
import 'package:hae_mo/model/user_response_model.dart';
import 'package:hae_mo/page/home_page.dart';
import 'package:http/http.dart' as http;

import '../model/post_response_model.dart';
import '../model/user_model.dart';

class DBService {
  Future<void> saveUser(User user) async {
    try {
      final response = await http.post(
        Uri.parse("http://localhost:1004/user"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJson()),
      );
      if (response.statusCode != 201) {
        throw Exception("Failed to send data");
      } else {
        print("User Data sent successfully");
        Get.to(const HomePage());
      }
    } catch (e) {
      print("Failed to send post data: ${e}");
    }
  }

  Future<void> savePost(Post post) async {
    try {
      final response = await http.post(
        Uri.parse("http://localhost:1004/post"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(post.toJson()),
      );
      if (response.statusCode != 201) {
        throw Exception("Failed to send data");
      } else {
        print("Post Data sent successfully");
        Get.to(const HomePage());
      }
    } catch (e) {
      print("Failed to send post data: ${e}");
    }
  }

  Future<List<PostResponse>> getAllPost() async {
    final response = await http.get(Uri.parse("http://localhost:1004/post"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      return data
          .map<PostResponse>((json) => PostResponse.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load post llist');
    }
  }

  Future<Post> getPostById(int id) async {
    final response =
        await http.get(Uri.parse("http://localhost:1004/post/$id"));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      return Post.fromJson(jsonData);
    } else if (response.statusCode == 404) {
      throw Exception("Post not found");
    } else {
      throw Exception("Failed to fetch Post by Id");
    }
  }

  Future<UserResponse> getUserByPost(int pId) async {
    final response =
        await http.get(Uri.parse("http://localhost:1004/post/postUser/$pId"));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      return UserResponse.fromJson(jsonData);
    } else if (response.statusCode == 404) {
      throw Exception("User not found");
    } else {
      throw Exception("Failed to fetch User by Post");
    }
  }

  Future<UserResponse> getUserByNickname(String nickname) async {
    final response =
        await http.get(Uri.parse("http://localhost:1004/user/$nickname"));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      return UserResponse.fromJson(jsonData);
    } else if (response.statusCode == 404) {
      throw Exception("User not found");
    } else {
      throw Exception("Failed to fetch User by Nickname");
    }
  }
}
