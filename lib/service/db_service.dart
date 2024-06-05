import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:hae_mo/model/acceptation_model.dart';
import 'package:hae_mo/model/acceptation_response_model.dart';
import 'package:hae_mo/model/club_post_model.dart';
import 'package:hae_mo/model/comment_model.dart';
import 'package:hae_mo/model/comment_response_model.dart';
import 'package:hae_mo/model/hotplace_post_model.dart';
import 'package:hae_mo/model/hotplace_post_response_model.dart';
import 'package:hae_mo/model/login_model.dart';
import 'package:hae_mo/model/notice_model.dart';
import 'package:hae_mo/model/notice_response_model.dart';
import 'package:hae_mo/model/post_model.dart';
import 'package:hae_mo/model/club_post_response_model.dart';
import 'package:hae_mo/model/reply_model.dart';
import 'package:hae_mo/model/reply_response_model.dart';
import 'package:hae_mo/model/user_response_model.dart';
import 'package:hae_mo/model/wish_meeting_model.dart';
import 'package:hae_mo/model/wish_model.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;
import '../model/post_response_model.dart';
import '../model/user_model.dart';
import '../model/wish_club_model.dart';

class DBService {
  Future<bool> saveUser(User user) async {
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
        Uri.parse("http://localhost:1004/post"),
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

  Future<List<PostResponse>> get24HoursPosts() async {
    final response =
        await http.get(Uri.parse("http://localhost:1004/post/24hours"));
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

  Future<UserResponse?> getUserById(int uId) async {
    final response =
        await http.get(Uri.parse("http://localhost:1004/user/find/$uId"));
    if (response.statusCode == 201) {
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      return UserResponse.fromJson(jsonData);
    } else if (response.statusCode == 404) {
      throw Exception("User not found");
    } else {
      throw Exception("Failed to fetch User by Nickname");
    }
  }

  Future<int> getUserByStudentId(int studentId) async {
    final response = await http
        .get(Uri.parse("http://localhost:1004/user/find/student/$studentId"));
    if (response.statusCode == 201) {
      return int.parse(response.body);
    } else {
      throw Exception("Failed to fetch User by studentId");
    }
  }

  Future<bool> saveClubPost(ClubPost post) async {
    try {
      final response = await http.post(
        Uri.parse("http://localhost:1004/club"),
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
    final response = await http.get(Uri.parse("http://localhost:1004/club"));
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
        await http.get(Uri.parse("http://localhost:1004/club/$id"));
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
        .get(Uri.parse("http://localhost:1004/club/clubPostUser/$pId"));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      return UserResponse.fromJson(jsonData);
    } else if (response.statusCode == 404) {
      throw Exception("User not found");
    } else {
      throw Exception("Failed to fetch User by Club Post");
    }
  }

  Future<UserResponse> getUserByHotPlace(int pId) async {
    final response =
        await http.get(Uri.parse("http://localhost:1004/hot/postUser/$pId"));
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
    final response = await http
        .get(Uri.parse('http://localhost:1004/postComment/commentPost/$pId'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse
          .map((e) => CommentResponse.fromJson(e, CommentResponseType.Post))
          .toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }

  Future<List<CommentResponse>> getClubCommentsByCpId(int cpId) async {
    final response = await http
        .get(Uri.parse('http://localhost:1004/clubComment/commentPost/$cpId'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse
          .map((e) => CommentResponse.fromJson(e, CommentResponseType.Club))
          .toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }

  Future<List<CommentResponse>> getHotPlaceCommentsByHpId(int hpId) async {
    final response = await http
        .get(Uri.parse('http://localhost:1004/hotComment/commentPost/$hpId'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse
          .map((e) => CommentResponse.fromJson(e, CommentResponseType.HotPlace))
          .toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }

  Future<bool> saveHotPlacePost(HotPlacePost post) async {
    try {
      final response = await http.post(
        Uri.parse("http://localhost:1004/hot"),
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
    final response = await http.get(Uri.parse("http://localhost:1004/hot"));
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
        await http.get(Uri.parse("http://localhost:1004/hot/$pId"));
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
    final response = await http.get(Uri.parse("http://localhost:1004/hot"));

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
  Future<List<HotPlacePostResponse>> getWishListByUser(int uId) async {
    final response =
        await http.get(Uri.parse('http://localhost:1004/wish/myList/$uId'));

    if (response.statusCode == 201) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((e) => HotPlacePostResponse.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load wish list');
    }
  }

  Future<bool> addWishList(Wish wish) async {
    try {
      final response = await http.post(
        Uri.parse("http://localhost:1004/wish"),
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
      Uri.parse('http://localhost:1004/wish/delete/$uId/$pId'),
    );
    if (response.statusCode == 204) {
      print('WishList deleted successfully');
    } else {
      throw Exception('Failed to delete WishList');
    }
  }

  Future<List<HotPlacePostResponse>> getWishListHpIdsByUser(int uId) async {
    final response =
        await http.get(Uri.parse('http://localhost:1004/wish/myList/$uId'));
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

  Future<bool> checkNicknameDuplicate(String nickname) async {
    final response = await http
        .get(Uri.parse("http://localhost:1004/user/isDuplicate/$nickname"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as bool;
      return data;
    } else {
      throw Exception('Failed to check nickname availability');
    }
  }

  /// 계정 삭제(상의 필요)
  /// 로그아웃 기능 구현 필요

  Future<bool> saveNotice(Notice notice) async {
    try {
      final response = await http.post(
        Uri.parse("http://localhost:1004/notice"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(notice.toJson()),
      );
      if (response.statusCode != 201) {
        throw Exception("Failed to notice data");
      } else {
        dev.log("Notice Data sent successfully");
        return true;
      }
    } catch (e) {
      dev.log("Failed to send notice data: ${e}");
      return false;
    }
  }

  Future<void> changeNoticeVisibility(int nId) async {
    try {
      final response = await http
          .get(Uri.parse("http://localhost:1004/notice/visible/$nId"));

      if (response.statusCode == 200) {
        // API 호출 성공
        print('Notice visibility changed successfully.');
      } else {
        // API 호출 실패
        print('Failed to change notice visibility.');
      }
    } catch (error) {
      // 에러 처리
      print('Error occurred while calling the API: $error');
    }
  }

  Future<List<Notice>> getAllNotice() async {
    final response = await http.get(Uri.parse("http://localhost:1004/notice"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      print("db service: ${data}");

      return data.map<Notice>((json) => Notice.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load hot list');
    }
  }

  /// 이건 어떤 용도?
  Future<List<NoticeResponse>> getNoticeById(int nId) async {
    final response =
        await http.get(Uri.parse("http://localhost:1004/notice/visible/$nId"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      return data
          .map<NoticeResponse>((json) => NoticeResponse.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load hot list');
    }
  }

  Future<bool> requestJoin(Acceptation acceptation) async {
    try {
      final response = await http.post(
        Uri.parse("http://localhost:1004/accept"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(acceptation.toJson()),
      );
      if (response.statusCode != 201) {
        throw Exception("Failed to notice data");
      } else {
        dev.log("Notice Data sent successfully");
        return true;
      }
    } catch (e) {
      dev.log("Failed to send notice data: ${e}");
      return false;
    }
  }

  Future<void> acceptUserToJoin(int uId, int pId) async {
    try {
      final response = await http
          .get(Uri.parse("http://localhost:1004/accept/accept/$uId/$pId"));

      if (response.statusCode != 201) {
        // API 호출 성공
        print('Failed to accetp user.');
        dev.log(response.statusCode.toString());
      } else {
        // API 호출 실패

        print('Accept User to join successfully.');
      }
    } catch (error) {
      // 에러 처리
      print('Error occurred while calling the API: $error');
    }
  }

  Future<void> cancleJoinRequest(int uId, int pId) async {
    final response = await http.delete(
      Uri.parse('http://localhost:1004/accept/delete/$uId/$pId'),
    );
    if (response.statusCode == 204) {
      print('Request deleted successfully');
    } else {
      throw Exception('Failed to delete Request');
    }
  }

  Future<AcceptationResponse> getRequestById(int uId, int pId) async {
    final response = await http
        .get(Uri.parse("http://localhost:1004/accept/check/$uId/$pId"));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      return AcceptationResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to load hot list');
    }
  }

  Future<bool> checkRequestExist(int uId, int pId) async {
    final response = await http
        .get(Uri.parse("http://localhost:1004/accept/isExist/$uId/$pId"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as bool;
      return data;
    } else {
      throw Exception('Failed to check nickname availability');
    }
  }

  Future<List<UserResponse>> getAttendUserList(int pId) async {
    final response =
        await http.get(Uri.parse("http://localhost:1004/accept/userList/$pId"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      return data
          .map<UserResponse>((json) => UserResponse.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load hot list');
    }
  }

  // ///유저의 찜한 게시물 가져오기
  // Future<List<WishMeetingResponse>> getWishMeetingListByUser(int uId) async {
  //   final response = await http
  //       .get(Uri.parse("http://localhost:1004/wishMeeting/myList/$uId"));
  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body) as List<dynamic>;
  //     return data
  //         .map<WishMeetingResponse>(
  //             (json) => WishMeetingResponse.fromJson(json))
  //         .toList();
  //   } else {
  //     throw Exception('Failed to load post llist');
  //   }
  // }

  Future<bool> checkWishMeetingExist(int uId, int pId) async {
    final response = await http
        .get(Uri.parse("http://localhost:1004/wishMeeting/isExist/$uId/$pId"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as bool;
      return data;
    } else {
      throw Exception('Failed to check wish Meeting exist.');
    }
  }

  Future<bool> addWishMeetingList(WishMeeting wish) async {
    try {
      final response = await http.post(
        Uri.parse("http://localhost:1004/wishMeeting"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(wish.toJson()),
      );
      if (response.statusCode != 201) {
        throw Exception("Failed to send data");
      } else {
        dev.log("Wish Meeting List Data sent successfully");
        return true;
      }
    } catch (e) {
      dev.log("Failed to send Wish Meeting List: ${e}");
      return false;
    }
  }

  Future<void> deleteWishMeetingList(int uId, int pId) async {
    final response = await http.delete(
      Uri.parse('http://localhost:1004/wishMeeting/delete/$uId/$pId'),
    );
    if (response.statusCode == 204) {
      print('WishList deleted successfully');
    } else {
      throw Exception('Failed to delete Wish Meeting List');
    }
  }

  Future<List<PostResponse>> getWishMeetingListByUser(int uId) async {
    final response = await http
        .get(Uri.parse('http://localhost:1004/wishMeeting/myList/$uId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      return data
          .map<PostResponse>((json) => PostResponse.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load post list');
    }
  }

  Future<bool> checkWishClubExist(int uId, int pId) async {
    final response = await http
        .get(Uri.parse("http://localhost:1004/wishClub/isExist/$uId/$pId"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as bool;
      return data;
    } else {
      throw Exception('Failed to check wish Meeting exist.');
    }
  }

  Future<bool> addWishClubList(WishClub wish) async {
    final response = await http.post(
      Uri.parse("http://localhost:1004/wishClub"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(wish.toJson()),
    );
    if (response.statusCode != 201) {
      print("에드 클럽 스테이터스: ${response.statusCode}");
      throw Exception("Failed to send wish club data");
    } else {
      dev.log("Wish club List Data sent successfully");
      return true;
    }
  }

  Future<void> deleteWishClubList(int uId, int pId) async {
    final response = await http.delete(
      Uri.parse('http://localhost:1004/wishClub/delete/$uId/$pId'),
    );
    if (response.statusCode == 204) {
      print('WishList deleted successfully');
    } else {
      print("딜리트 클럽 스테이터스: ${response.statusCode}");
      throw Exception('Failed to delete Wish Meeting List');
    }
  }

  Future<List<ClubPostResponse>> getWishClubListByUser(int uId) async {
    final response =
        await http.get(Uri.parse('http://localhost:1004/wishClub/myList/$uId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      return data
          .map<ClubPostResponse>((json) => ClubPostResponse.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load post list');
    }
  }

  Future<bool> sendClubComment(Comment comment) async {
    try {
      final response = await http.post(
        Uri.parse("http://localhost:1004/clubComment"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(comment.toJson()),
      );
      if (response.statusCode != 201) {
        throw Exception("Failed to send comment data");
      } else {
        dev.log("Post Comment Data sent successfully");
        return true;
        //Get.to(() => const HomePage());
      }
    } catch (e) {
      dev.log("Failed to send post comment: ${e}");
      return false;
    }
  }

  Future<bool> sendHotPlaceComment(Comment comment) async {
    try {
      final response = await http.post(
        Uri.parse("http://localhost:1004/hotComment"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(comment.toJson()),
      );
      if (response.statusCode != 201) {
        throw Exception("Failed to send comment data");
      } else {
        dev.log("Post Comment Data sent successfully");
        return true;
      }
    } catch (e) {
      dev.log("Failed to send post comment: ${e}");
      return false;
    }
  }

  Future<bool> sendComment(Comment comment) async {
    try {
      final response = await http.post(
        Uri.parse("http://localhost:1004/postComment"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(comment.toJson()),
      );
      if (response.statusCode != 201) {
        throw Exception("Failed to send comment data");
      } else {
        dev.log("Post Comment Data sent successfully");
        return true;
        //Get.to(() => const HomePage());
      }
    } catch (e) {
      dev.log("Failed to send post comment: ${e}");
      return false;
    }
  }

  /// user_listchat DB
  /// 채팅방 처음 생성 시 uId, 처음 생긴 채팅방 id로 데이터 생성(채팅방 id는 파이어베이스에서 내가 받아옴)
/*  Future<void> saveChatList(int uId, String chatId){

  }*/

  /// uId를 바탕으로 채팅방 id 추가
/*  Future<void> updateChatId(int uId){

  }*/

  /// uId를 바탕으로 채팅방 id 삭제
/*  Future<void> deleteChatId(int uId, String chatId){

  }*/

  Future<List<ReplyResponse>> getReplysByCId(int cId) async {
    final response = await http
        .get(Uri.parse('http://localhost:1004/postReply/commentPost/$cId'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse
          .map((e) => ReplyResponse.fromJson(e, ReplyResponseType.Post))
          .toList();
    } else {
      throw Exception('Failed to load replys.');
    }
  }

  Future<List<ReplyResponse>> getClubReplysByCcId(int ccId) async {
    final response = await http
        .get(Uri.parse('http://localhost:1004/clubReply/commentPost/$ccId'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse
          .map((e) => ReplyResponse.fromJson(e, ReplyResponseType.Club))
          .toList();
    } else {
      throw Exception('Failed to load club replys.');
    }
  }

  Future<List<ReplyResponse>> getHotPlaceReplysByHcId(int hcId) async {
    final response = await http
        .get(Uri.parse('http://localhost:1004/hotReply/commentPost/$hcId'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse
          .map((e) => ReplyResponse.fromJson(e, ReplyResponseType.HotPlace))
          .toList();
    } else {
      throw Exception('Failed to load hotplace replys.');
    }
  }

  Future<bool> sendReply(Reply reply) async {
    try {
      final response = await http.post(
        Uri.parse("http://localhost:1004/postReply"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(reply.toJson()),
      );
      if (response.statusCode != 201) {
        throw Exception("Failed to send comment data");
      } else {
        dev.log("Post reply Data sent successfully");
        return true;
      }
    } catch (e) {
      dev.log("Failed to send post reply: ${e}");
      return false;
    }
  }

  Future<bool> sendClubReply(Reply reply) async {
    try {
      final response = await http.post(
        Uri.parse("http://localhost:1004/clubReply"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(reply.toJson()),
      );
      if (response.statusCode != 201) {
        throw Exception("Failed to send comment data");
      } else {
        dev.log("Post reply Data sent successfully");
        return true;
      }
    } catch (e) {
      dev.log("Failed to send post reply: ${e}");
      return false;
    }
  }

  Future<bool> sendHotPlaceReply(Reply reply) async {
    try {
      final response = await http.post(
        Uri.parse("http://localhost:1004/postReply"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(reply.toJson()),
      );
      if (response.statusCode != 201) {
        throw Exception("Failed to send comment data");
      } else {
        dev.log("Post reply Data sent successfully");
        return true;
      }
    } catch (e) {
      dev.log("Failed to send post reply: ${e}");
      return false;
    }
  }

  Future<List<UserResponse>> getCommentUser(int pId) async {
    final response = await http
        .get(Uri.parse("http://localhost:1004/postComment/commentUser/$pId"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      return data
          .map<UserResponse>((json) => UserResponse.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load hot list');
    }
  }

  Future<List<UserResponse>> getClubCommentUser(int pId) async {
    final response = await http
        .get(Uri.parse("http://localhost:1004/clubComment/commentUser/$pId"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      return data
          .map<UserResponse>((json) => UserResponse.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load hot list');
    }
  }

  Future<List<UserResponse>> getHotPlaceCommentUser(int pId) async {
    final response = await http
        .get(Uri.parse("http://localhost:1004/hotComment/commentUser/$pId"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      return data
          .map<UserResponse>((json) => UserResponse.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load hot list');
    }
  }

  Future<void> uploadImage(String cpId, Uint8List imageBytes) async {
    try {
      if (cpId.isNotEmpty && imageBytes.isNotEmpty) {
        String url = 'http://localhost:1004/club/uploadImage';
        Map<String, String> headers = {
          'Content-Type': 'application/json',
        };
        Map<String, dynamic> body = {
          "imageData": base64Encode(imageBytes),
          "cpId": cpId,
        };

        final response = await http.post(
          Uri.parse(url),
          headers: headers,
          body: jsonEncode(body),
        );

        if (response.statusCode == 200) {
          print("Image uploaded successfully.");
        } else {
          print("Image upload failed.");
        }
      } else {
        print("Please provide cpId and select an image.");
      }
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  Future<Uint8List?> getImage(String cpId) async {
    try {
      if (cpId.isNotEmpty) {
        String url = 'http://localhost:1004/club/imageList/$cpId';

        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          String base64Image = jsonDecode(response.body);
          Uint8List imageBytes = base64Decode(base64Image);

          return imageBytes;
        } else {
          print("Failed to get image.");
          return null;
        }
      } else {
        print("Please provide a valid cpId.");
        return null;
      }
    } catch (e) {
      print("Error getting image: $e");
      return null;
    }
  }

  Future<List<List<int>>?> fetchHotPlaceImages(int pId) async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:1004/hot/$pId/getImages'));

      if (response.statusCode == 200) {
        List<dynamic> imageList = jsonDecode(response.body);
        List<List<int>> decodedImages = [];

        for (var imageData in imageList) {
          // 이미지 데이터를 바이트 리스트로 변환
          List<int> imageBytes = imageData.cast<int>();
          decodedImages.add(imageBytes);
        }

        return decodedImages;
      } else {
        print("fail to load image list from hotplace data.");
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<AcceptationResponse>> getAttendList(int pId) async {
    final response = await http
        .get(Uri.parse("http://localhost:1004/accept/attendList/$pId"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      return data
          .map<AcceptationResponse>(
              (json) => AcceptationResponse.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load attend list');
    }
  }

  Future<bool> signIn(LoginRequestModel loginModel) async {
    try {
      final response = await http.post(
        Uri.parse("http://localhost:1004/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(loginModel.toJson()),
      );
      if (response.statusCode == 200) {
        dev.log("Successfully done");
        return response.body == "true" ? true : false;
      } else {
        dev.log("결과: ${response.statusCode}");
        throw Exception("Failed to sign in");
      }
    } catch (e) {
      dev.log("Failed to sign in: ${e}");
      return false;
    }
  }
}
