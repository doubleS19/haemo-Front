import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hae_mo/common/color.dart';
import 'package:hae_mo/controller/meeting_page_controller.dart';
import 'package:hae_mo/model/club_post_model.dart';
import 'package:hae_mo/model/user_response_model.dart';
import 'package:hae_mo/screens/components/commentWidget.dart';
import 'package:hae_mo/screens/components/wishStarButton.dart';
import 'package:hae_mo/utils/shared_preference.dart';
import '../../../model/post_model.dart';
import '../../../service/db_service.dart';
import '../../components/heartButton.dart';
import '../../components/userBottomSheet.dart';

class BoardDetailPage extends StatefulWidget {
  const BoardDetailPage({super.key, required this.pId, required this.type});

  final int pId;
  final int type;

  @override
  State<BoardDetailPage> createState() => _BoardDetailPageState();
}

class _BoardDetailPageState extends State<BoardDetailPage> {
  double _textFieldHeight = 35.0;
  MeetingPageController meetingController = MeetingPageController();
  bool fillWishColor = false;
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DBService db = DBService();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0.0,
        automaticallyImplyLeading: true,
        actions: [
          WishStarButton(
              fillHeart: fillWishColor,
              uId: PreferenceUtil.getInt("uId")!,
              pId: widget.pId)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Divider(
            color: AppTheme.mainColor,
            thickness: 1.0,
          ),
          if (widget.type == 1) ...[
            FutureBuilder(
              future: db.getPostById(widget.pId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final Post post = snapshot.data as Post;
                  return FutureBuilder(
                    future: db.getUserByPost(widget.pId),
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        final UserResponse user = snapshot.data as UserResponse;
                        return Container(
                          margin:
                              const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                      width: 41.0,
                                      height: 41.0,
                                      child: RawMaterialButton(
                                          elevation: 0.0,
                                          fillColor: Colors.transparent,
                                          shape: CircleBorder(),
                                          onPressed: (() {
                                            userBottomSheet(context, user);
                                          }),
                                          child: Container(
                                            width: 41,
                                            height: 41,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.transparent,
                                              image: DecorationImage(
                                                image:
                                                    AssetImage(user.userImage),
                                              ),
                                            ),
                                          ))),
                                  const SizedBox(width: 10.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user.nickname,
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: AppTheme.mainTextColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '${user.major}  /  ',
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: AppTheme.mainTextColor,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            user.gender,
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: AppTheme.mainTextColor,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30.0),
                              Text(
                                post.title,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: AppTheme.mainTextColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Divider(color: AppTheme.mainTextColor),
                              const SizedBox(height: 10.0),
                              Container(
                                margin: const EdgeInsets.only(bottom: 10.0),
                                width: double.infinity,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 20.0),
                                    Text(
                                      post.content,
                                      style: TextStyle(
                                        color: AppTheme.mainTextColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 20,
                                    ),
                                    const SizedBox(height: 20.0),
                                  ],
                                ),
                              ),
                              Divider(color: AppTheme.mainTextColor),
                              commentWidget(widget.pId, widget.type),
                            ],
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text("${snapshot.error}"),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("${snapshot.error}"),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ] else ...[
            FutureBuilder(
              future: db.getClubPostById(widget.pId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final ClubPost post = snapshot.data as ClubPost;
                  return FutureBuilder(
                    future: db.getUserByClubPost(widget.pId),
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        final UserResponse user = snapshot.data as UserResponse;
                        return Container(
                          margin:
                              const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                      width: 41.0,
                                      height: 41.0,
                                      child: RawMaterialButton(
                                          elevation: 0.0,
                                          fillColor: Colors.transparent,
                                          shape: CircleBorder(),
                                          onPressed: (() {
                                            userBottomSheet(context, user);
                                          }),
                                          child: Container(
                                            width: 41,
                                            height: 41,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.transparent,
                                              image: DecorationImage(
                                                image:
                                                    AssetImage(user.userImage),
                                              ),
                                            ),
                                          ))),
                                  const SizedBox(width: 10.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user.nickname,
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: AppTheme.mainTextColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '${user.major}  /  ',
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: AppTheme.mainTextColor,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            user.gender,
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: AppTheme.mainTextColor,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30.0),
                              Text(
                                post.title,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: AppTheme.mainTextColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Divider(color: AppTheme.mainTextColor),
                              const SizedBox(height: 10.0),
                              Container(
                                margin: const EdgeInsets.only(bottom: 10.0),
                                width: double.infinity,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 20.0),
                                    Text(
                                      post.content,
                                      style: TextStyle(
                                        color: AppTheme.mainTextColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 20,
                                    ),
                                    const SizedBox(height: 20.0),
                                  ],
                                ),
                              ),
                              Divider(color: AppTheme.mainTextColor),
                              commentWidget(widget.pId, widget.type),
                            ],
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text("${snapshot.error}"),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("${snapshot.error}"),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ]),
      ),
    );
  }
}
