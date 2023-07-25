import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hae_mo/common/color.dart';
import 'package:hae_mo/model/post_response_model.dart';
import 'package:hae_mo/model/shared_preference.dart';
import 'package:hae_mo/screens/page/board_detail_page.dart';
import '../../service/db_service.dart';

class MyMeetingPage extends StatefulWidget {
  const MyMeetingPage({super.key});

  @override
  State<MyMeetingPage> createState() => _MyMeetingPageState();
}

class _MyMeetingPageState extends State<MyMeetingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0.0,
          title: const Text(
            "내가 작성한 글",
            style: TextStyle(
              color: Color(0xff595959),
              fontSize: 19.0,
            ),
          ),
          automaticallyImplyLeading: true,
        ),
        body: Container(
            margin: const EdgeInsets.only(right: 10.0, left: 10.0),
            color: Colors.white,
            child: Column(children: [
              Divider(
                color: AppTheme.dividerColor,
                thickness: 0.5,
              ),
              Expanded(flex: 3, child: myBoardList())
            ])));
  }

  Widget myBoardList() {
    DBService db = DBService();
    return FutureBuilder(
        future: db.getAllPost(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<PostResponse> postList =
                snapshot.data as List<PostResponse>;
            postList.removeWhere((element) =>
                element.nickname != PreferenceUtil.getString("nickname"));
            if (postList.isEmpty) {
              return Center(
                  child: Text(
                "아직 작성한 게시물이 없어요!",
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: AppTheme.mainPageTextColor),
              ));
            } else {
              return ListView.builder(
                  itemCount: postList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          Get.to(() => BoardDetailPage(
                              pId: postList[index].pId, type: 1));
                        },
                        child: Column(children: [
                          Container(
                              height: 50.0,
                              width: double.infinity,
                              margin:
                                  const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                              padding:
                                  const EdgeInsets.only(left: 5.0, right: 5.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            postList[index].title,
                                            style: TextStyle(
                                                color:
                                                    AppTheme.mainPageTextColor,
                                                fontSize: 13.5,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            "3/${postList[index].person}",
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: AppTheme
                                                    .mainPagePersonColor,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 13.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${postList[index].person}명",
                                            style: TextStyle(
                                                color: AppTheme
                                                    .mainPageSubTextColor,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          Text(
                                            postList[index].date,
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: AppTheme.mainPageTextColor,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ))),
                          const Divider(
                              thickness: 1.0, color: Color(0xffbbbbbb))
                        ]));
                  });
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
