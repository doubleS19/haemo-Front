import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hae_mo/common/color.dart';
import 'package:hae_mo/model/club_post_response_model.dart';
import 'package:standard_searchbar/standard_searchbar.dart';
import '../../../controller/club_page_controller.dart';
import '../../components/customAppBar.dart';
import 'board_detail_page.dart';

class ClubPage extends StatefulWidget {
  const ClubPage({super.key});

  @override
  State<ClubPage> createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage> {
  final ClubPageController clubController = Get.find<ClubPageController>();
  String searchText = '';

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    clubController.fetchClubPostList();
  }

  @override
  Widget build(BuildContext context) {
    clubController.fetchClubPostList();
    final postList = clubController.clubList;

    return Scaffold(
        appBar: customMainAppbar("소모임/동아리 게시판", "공지 24시간"),
        body: GestureDetector(
          onTap: () {
            _focusNode.unfocus();
          },
          child: Container(
            alignment: Alignment.center,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  height: 13.0,
                  margin: const EdgeInsets.fromLTRB(30.0, 10.0, 0.0, 5.0),
                  alignment: Alignment.centerLeft,
                  child: Obx(
                    () => Text(
                      "총 ${clubController.clubList.length}개의 동아리&소모임이 있습니다.",
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Color(0xff838383),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                    height: 30.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(23.0)),
                    child: TextFormField(
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10.0),
                          constraints: const BoxConstraints(
                              minHeight: 30.0, maxHeight: 30.0),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(23.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(23.0)),
                          fillColor: AppTheme.clubPageSearchBarColor,
                          hintText: '검색어를 입력해 주세요.'),
                      style: TextStyle(
                          fontSize: 14.0, color: AppTheme.mainTextColor),
                      cursorColor: AppTheme.mainTextColor,
                      onChanged: (value) {
                        setState(() {
                          searchText = value;
                        });
                      },
                    )),
                Expanded(flex: 3, child: clubList(postList, searchText)),
              ],
            ),
          ),
        ));
  }

  Widget clubList(RxList<ClubPostResponse> postList, String search) {
    return Obx(
      () {
        if (postList.isEmpty && clubController.clubList.isEmpty) {
          return Center(
            child: Text(
              "게시물이 없어요!",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: AppTheme.mainPageTextColor,
              ),
            ),
          );
        } else {
          return ListView.builder(
              itemCount: postList.length,
              itemBuilder: (BuildContext context, int index) {
                final post = postList[index];
                if (searchText.isEmpty ||
                    post.title.toLowerCase().contains(search.toLowerCase())) {
                  return GestureDetector(
                      onTap: () {
                        Get.to(() => BoardDetailPage(
                            pId: post.pId,
                            type: 2,
                            meetingPost: null,
                            clubPost: post));
                      },
                      child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          child: Column(children: [
                            Row(children: [
                              if (post.logo == null) ...[
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppTheme.mainTextColor,
                                    image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/sunset.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ] else ...[
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppTheme.mainTextColor,
                                    image: DecorationImage(
                                      image: Image.network(post.logo.toString())
                                          .image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                              const SizedBox(
                                width: 10.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "상시 모집",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 9.0,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.mainPagePersonColor),
                                  ),
                                  Text(
                                    post.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.clubPageTitleColor),
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  SizedBox(
                                      width: 169.0,
                                      height: 33.0,
                                      child: Text(
                                        post.description,
                                        maxLines: 3,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                            fontSize: 9.0,
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.clubPageTitleColor),
                                      )),
                                ],
                              )
                            ]),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Divider(
                                thickness: 1.0, color: AppTheme.dividerColor),
                          ])));
                } else {
                  return Container();
                }
              });
        }
      },
    );
  }
}
