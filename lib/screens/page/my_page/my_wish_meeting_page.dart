import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hae_mo/common/color.dart';
import 'package:hae_mo/model/post_response_model.dart';
import 'package:hae_mo/screens/Page/board/board_detail_page.dart';
import 'package:hae_mo/screens/components/wishStarButton.dart';
import 'package:hae_mo/service/db_service.dart';
import 'package:hae_mo/utils/shared_preference.dart';

class MyWishMeetingPage extends StatefulWidget {
  const MyWishMeetingPage({super.key});

  @override
  State<MyWishMeetingPage> createState() => _MyWishMeetingPageState();
}

class _MyWishMeetingPageState extends State<MyWishMeetingPage> {
  List<PostResponse> postList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0.0,
          title: const Text(
            "가고 싶은 모임",
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
              Expanded(flex: 3, child: myWishMeetingList(postList))
            ])));
  }

  myWishMeetingList(List<PostResponse> postList) {
    if (postList.isEmpty) {
      return const Center(
          child: Text(
        "아직 찜한 게시물이 없어요!",
        style: TextStyle(
            fontWeight: FontWeight.w300, color: AppTheme.mainPageTextColor),
      ));
    } else {
      return ListView.builder(
          itemCount: postList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: () {
                  Get.to(
                      () => BoardDetailPage(pId: postList[index].pId, type: 1));
                },
                child: Expanded(
                    child: Column(children: [
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppTheme.borderColor, width: 0.8),
                          borderRadius: BorderRadius.circular(15.0)),
                      width: double.infinity,
                      margin: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                      padding:
                          const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Expanded(
                              child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      flex: 4,
                                      child: Text(
                                        postList[index].title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: AppTheme.mainPageTextColor,
                                            fontSize: 13.5,
                                            fontWeight: FontWeight.w600),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Row(children: [
                                        Text(
                                          "3/${postList[index].person}",
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: AppTheme.mainColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                            width: 30.0,
                                            height: 30.0,
                                            child: WishStarButton(
                                                uId: PreferenceUtil.getInt(
                                                    "uId")!,
                                                pId: postList[index].pId,
                                                type: 1))
                                      ]))
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
                                    style: const TextStyle(
                                        color: AppTheme.mainPageTextColor,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Text(
                                    postList[index].date,
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      color: AppTheme.mainPageTextColor,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )))),
                ])));
          });
    }
  }
}
