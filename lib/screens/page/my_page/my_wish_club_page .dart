import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haemo/common/color.dart';
import 'package:haemo/controller/wish_controller.dart';
import 'package:haemo/model/club_post_response_model.dart';
import 'package:haemo/model/wish_model.dart';
import 'package:haemo/screens/Page/board/board_detail_page.dart';
import 'package:haemo/screens/components/wishStarButton.dart';
import 'package:haemo/utils/shared_preference.dart';

class MyWishClubPage extends StatefulWidget {
  const MyWishClubPage({super.key});

  @override
  State<MyWishClubPage> createState() => _MyWishClubPageState();
}

class _MyWishClubPageState extends State<MyWishClubPage> {
  List<ClubPostResponse> postList = [];
  WishController wishController = WishController();

  @override
  void initState() {
    super.initState();
    wishController.fetchWishClubPost();
  }

  @override
  build(BuildContext context) {
    wishController.wishClubPost.listen((value) {
      setState(() {
        postList = value;
      });
    });

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0.0,
          title: const Text(
            "가고 싶은 소모임",
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
              const Divider(
                color: AppTheme.dividerColor,
                thickness: 0.5,
              ),
              Expanded(flex: 3, child: myWishClubList(postList))
            ])));
  }

  myWishClubList(List<ClubPostResponse> postList) {
    if (postList.isEmpty) {
      return const Center(
          child: Text(
        "아직 찜한 소모임이 없어요!",
        style: TextStyle(
            fontWeight: FontWeight.w300, color: AppTheme.mainPageTextColor),
      ));
    } else {
      return ListView.builder(
          itemCount: postList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: () {
                  Get.to(() => BoardDetailPage(
                      pId: postList[index].pId,
                      type: 2,
                      clubPost: postList[index]));
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
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      flex: 5,
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
                                  )
                                ],
                              )
                            ],
                          ))),
                ])));
          });
    }
  }
}
