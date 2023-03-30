import 'dart:convert';
import 'package:hae_mo/model/post_model.dart';
import 'package:http/http.dart' as http;

class DBService {
  // Future savePostDB(Post post) async {
  //   List<Post> list = [];
  //   final response = await http
  //       .get(Uri.parse("haemo.cyl5voziv2j0.ap-northeast-2.rds.amazonaws.com"));

  //   if (response.statusCode == 200) {
  //     final result = utf8.decode(response.bodyBytes);
  //     List<Post> json = jsonDecode(result)['qry_result'];

  //     for (int i = 0; i < json.length; i++) {
  //       list.add(post.fromJson(json[i]));
  //     }
  //   }
  // }

  Future<void> savePost(Post post) async {
    final response = await http.post(
      Uri.parse("http://localhost:8080/post"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(post.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception("Failed to send data");
    }
  }
}
