import 'dart:convert';
import 'package:hae_mo/model/club_comment_response_model.dart';
import 'package:hae_mo/model/club_post_model.dart';
import 'package:hae_mo/model/comment_response_model.dart';
import 'package:hae_mo/model/hotplace_comment_response_model.dart';
import 'package:hae_mo/model/hotplace_post_model.dart';
import 'package:hae_mo/model/hotplace_post_response_model.dart';
import 'package:hae_mo/model/post_model.dart';
import 'package:hae_mo/model/club_post_response_model.dart';
import 'package:hae_mo/model/user_response_model.dart';
import 'package:hae_mo/model/wish_model.dart';
import 'package:hae_mo/model/wish_response_model.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;
import '../model/post_response_model.dart';
import '../model/user_model.dart';

class DBService {
  Future<bool> saveUser(User user) async {
    try {
      final response = await http.post(
        Uri.parse("http://43.201.211.1:1004/user"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode != 201) {
        throw Exception("Failed to send data");
      } else {
        dev.log("User Data sent successfully");
        return true;
      }
    } catch (e) {
      dev.log("Failed to send post data: ${e}");
      return false;
    }
  }

  Future<bool> savePost(Post post) async {
    try {
      final response = await http.post(
        Uri.parse("http://43.201.211.1:1004/post"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(post.toJson()),
      );
      if (response.statusCode != 201) {
        throw Exception("Failed to send data");
      } else {
        dev.log("Post Data sent successfully");
        return true;
      }
    } catch (e) {
      dev.log("Failed to send post data: ${e}");
      return false;
    }
  }

  Future<List<PostResponse>> getAllPost() async {
    final response = await http.get(Uri.parse("http://43.201.211.1:1004/post"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      return data
          .map<PostResponse>((json) => PostResponse.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load post llist');
    }
  }

  Future<List<PostResponse>> get24HoursPosts() async {
    final response =
        await http.get(Uri.parse("http://43.201.211.1:1004/post/24hours"));
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
        await http.get(Uri.parse("http://43.201.211.1:1004/post/$id"));
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
    final response = await http
        .get(Uri.parse("http://43.201.211.1:1004/post/postUser/$pId"));
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
        await http.get(Uri.parse("http://43.201.211.1:1004/user/$nickname"));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      return UserResponse.fromJson(jsonData);
    } else if (response.statusCode == 404) {
      throw Exception("User not found");
    } else {
      throw Exception("Failed to fetch User by Nickname");
    }
  }

  Future<bool> saveClubPost(ClubPost post) async {
    try {
      final response = await http.post(
        Uri.parse("http://43.201.211.1:1004/club"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(post.toJson()),
      );
      if (response.statusCode != 201) {
        throw Exception("Failed to send data");
      } else {
        dev.log("Club Post Data sent successfully");
        return true;
        //Get.to(() => const HomePage());
      }
    } catch (e) {
      dev.log("Failed to send post data: ${e}");
      return false;
    }
  }

  Future<List<ClubPostResponse>> getAllClubPost() async {
    final response = await http.get(Uri.parse("http://43.201.211.1:1004/club"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      return data
          .map<ClubPostResponse>((json) => ClubPostResponse.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load post llist');
    }
  }

  Future<ClubPost> getClubPostById(int id) async {
    final response =
        await http.get(Uri.parse("http://43.201.211.1:1004/club/$id"));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      return ClubPost.fromJson(jsonData);
    } else if (response.statusCode == 404) {
      throw Exception("Club Post not found");
    } else {
      throw Exception("Failed to fetch Post by Id");
    }
  }

  Future<UserResponse> getUserByClubPost(int pId) async {
    final response = await http
        .get(Uri.parse("http://43.201.211.1:1004/club/clubPostUser/$pId"));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      return UserResponse.fromJson(jsonData);
    } else if (response.statusCode == 404) {
      throw Exception("User not found");
    } else {
      throw Exception("Failed to fetch User by Post");
    }
  }

  Future<List<CommentResponse>> getCommentsByPId(int pId) async {
    final response = await http.get(
        Uri.parse('http://43.201.211.1:1004/postComment/commentPost/$pId'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((e) => CommentResponse.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }

  Future<List<ClubCommentResponse>> getClubCommentsByCpId(int cpId) async {
    final response = await http.get(
        Uri.parse('http://43.201.211.1:1004/clubComment/commentPost/$cpId'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((e) => ClubCommentResponse.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }

  Future<List<HotPlaceCommentResponse>> getHotPlaceCommentsByHpId(
      int hpId) async {
    final response = await http.get(
        Uri.parse('http://43.201.211.1:1004/hotComment/commentPost/$hpId'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse
          .map((e) => HotPlaceCommentResponse.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }

  Future<bool> saveHotPlacePost(HotPlacePost post) async {
    try {
      final response = await http.post(
        Uri.parse("http://43.201.211.1:1004/hot"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(post.toJson()),
      );
      if (response.statusCode != 201) {
        throw Exception("Failed to send data");
      } else {
        dev.log("HotPlace Post Data sent successfully");
        return true;
      }
    } catch (e) {
      dev.log("Failed to send post data: ${e}");
      return false;
    }
  }

  Future<List<HotPlacePostResponse>> getAllHotPlacePost() async {
    final response = await http.get(Uri.parse("http://43.201.211.1:1004/hot"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      return data
          .map<HotPlacePostResponse>(
              (json) => HotPlacePostResponse.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load hot list');
    }
  }

  Future<List<HotPlacePostResponse>> getHotPlaceById(int pId) async {
    final response =
        await http.get(Uri.parse("http://43.201.211.1:1004/hot/$pId"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      return data
          .map<HotPlacePostResponse>(
              (json) => HotPlacePostResponse.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load hot list');
    }
  }

  Future<List<HotPlacePostResponse>> getPopularHotPlacePosts() async {
    final response = await http.get(Uri.parse("http://43.201.211.1:1004/hot"));

    ///   수정하기
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      return data
          .map<HotPlacePostResponse>(
              (json) => HotPlacePostResponse.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load popular hot place list');
    }
  }

  ///유저의 wishList(찜한 핫플) 가져오기
  Future<List<WishResponse>> getWishListByUser(int uId) async {
    final response =
        await http.get(Uri.parse('http://43.201.211.1:1004/wish/myList/$uId'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((e) => WishResponse.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load wish list');
    }
  }

  Future<bool> addWishList(Wish wish) async {
    try {
      final response = await http.post(
        Uri.parse("http://43.201.211.1:1004/wish"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(wish.toJson()),
      );
      if (response.statusCode != 201) {
        throw Exception("Failed to send data");
      } else {
        dev.log("WishList Data sent successfully");
        return true;
      }
    } catch (e) {
      dev.log("Failed to send WishList: ${e}");
      return false;
    }
  }

  Future<void> deleteWishList(int uId, int pId) async {
    final response = await http.delete(
      Uri.parse('http://43.201.211.1:1004/wish/delete/$uId/$pId'),
    );
    if (response.statusCode == 204) {
      print('WishList deleted successfully');
    } else {
      throw Exception('Failed to delete WishList');
    }
  }

  Future<List<HotPlacePostResponse>> getWishListHpIdsByUser(int uId) async {
    final response =
        await http.get(Uri.parse('http://43.201.211.1:1004/wish/myList/$uId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      return data
          .map<HotPlacePostResponse>(
              (json) => HotPlacePostResponse.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load hot list');
    }
  }

  /// 계정 삭제(상의 필요)
  /// 로그아웃 기능 구현 필(
}
