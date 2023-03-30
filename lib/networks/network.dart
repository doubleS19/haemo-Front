import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/post_model.dart';

class Network {
  static final Network _instance = Network._internal();
  factory Network() => _instance;
  Network._internal();

  Future<Post> getData(String url) async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return Post.fromJson(jsonBody);
    } else {
      throw Exception('Failed to load post');
    }
  }
}
