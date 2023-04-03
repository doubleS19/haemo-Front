import 'dart:convert';
import 'package:get/get.dart';
import 'package:hae_mo/model/post_model.dart';
import 'package:hae_mo/page/home_page.dart';
import 'package:http/http.dart' as http;

import '../model/user_model.dart';

class DBService {
  Future<void> saveUser(User user) async {
    try {
      final response = await http.post(
        Uri.parse("http://localhost:8080/user"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJson()),
      );
      if (response.statusCode != 201) {
        throw Exception("Failed to send user data");
      } else {
        print("data send");
        Get.to(const HomePage());
      }
    } catch (e) {
      print("Failed to send user data: ${e}");
    }
  }

  Future<void> savePost(Post post) async {
    try {
      final response = await http.post(
        Uri.parse("http://localhost:8080/post"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(post.toJson()),
      );
      if (response.statusCode != 201) {
        throw Exception("Failed to send data");
      } else {
        print("data send");
        Get.to(HomePage());
      }
    } catch (e) {
      print("Failed to send post data: ${e}");
    }
  }
}
