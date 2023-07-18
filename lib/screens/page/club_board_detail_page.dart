import 'package:flutter/material.dart';
import 'package:hae_mo/common/color.dart';
import 'package:hae_mo/model/club_post_model.dart';
import 'package:hae_mo/model/user_response_model.dart';
import '../../service/db_service.dart';

class ClubBoardDetailPage extends StatefulWidget {
  const ClubBoardDetailPage({super.key, required this.pId});

  final int pId;

  @override
  State<ClubBoardDetailPage> createState() => _ClubBoardDetailPageState();
}

class _ClubBoardDetailPageState extends State<ClubBoardDetailPage> {
  @override
  Widget build(BuildContext context) {
    DBService db = DBService();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0.0,
          title: Text(
            "게시물 조회",
            style: TextStyle(
              color: AppTheme.mainAppBarColor,
              fontSize: 19.0,
            ),
          ),
          automaticallyImplyLeading: true,
        ),
        body: Column(children: [
          Divider(
            color: AppTheme.mainColor,
            thickness: 1.0,
          ),
          FutureBuilder(
              future: db.getClubPostById(widget.pId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final ClubPost post = snapshot.data as ClubPost;
                  return FutureBuilder(
                      future: db.getUserByClubPost(widget.pId),
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          final UserResponse user =
                              snapshot.data as UserResponse;
                          return Container(
                              margin: const EdgeInsets.fromLTRB(
                                  20.0, 10.0, 20.0, 0.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    Container(
                                      width: 41,
                                      height: 41,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppTheme.mainTextColor,
                                          image: const DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/sunset.jpg'))),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(user.nickname,
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: AppTheme.mainTextColor,
                                                fontWeight: FontWeight.w600)),
                                        Row(
                                          children: [
                                            Text('${user.major}  /  ',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color:
                                                        AppTheme.mainTextColor,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            Text(user.gender,
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color:
                                                        AppTheme.mainTextColor,
                                                    fontWeight:
                                                        FontWeight.w400))
                                          ],
                                        )
                                      ],
                                    )
                                  ]),
                                  const SizedBox(
                                    height: 30.0,
                                  ),
                                  Text(
                                    post.title,
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: AppTheme.mainTextColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Divider(color: AppTheme.mainTextColor),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Container(
                                      margin:
                                          const EdgeInsets.only(bottom: 10.0),
                                      width: double.infinity,
                                      child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 20.0,
                                            ),
                                            Text(
                                              post.content,
                                              style: TextStyle(
                                                  color: AppTheme.mainTextColor,
                                                  fontWeight: FontWeight.w400),
                                              maxLines: 20,
                                            ),
                                            const SizedBox(
                                              height: 20.0,
                                            ),
                                          ])),
                                  Divider(color: AppTheme.mainTextColor),
                                  Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                          margin: const EdgeInsets.only(
                                              right: 30, left: 30.0),
                                          height: 45.0,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0)),
                                                backgroundColor:
                                                    AppTheme.mainColor),
                                            onPressed: (() {
                                              // Get.to(ChatRoom(
                                              //     chatRoomId:
                                              //         "20191520282019156027"));
                                            }),
                                            child: const Text(
                                              "주문하신 채팅하기 버튼 나왔습니다.",
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ))),
                                ],
                              ));
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text("${snapshot.error}"),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }));
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("${snapshot.error}"),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              })
        ]));
  }
}
