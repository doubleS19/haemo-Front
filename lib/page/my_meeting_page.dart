import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hae_mo/model/post_response_model.dart';
import 'package:hae_mo/page/board_detail_page.dart';
import '../service/db_service.dart';

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
            "헤모",
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
              const Divider(thickness: 0.5, color: Color(0xffbbbbbb)),
              const SizedBox(
                height: 10.0,
              ),
              const Text("내가 작성한 글",
                  style: TextStyle(
                      color: Color(0xff818181),
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0)),
              const SizedBox(
                height: 10.0,
              ),
              const Divider(
                color: Color(0xffbbbbbb),
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
            postList.removeWhere((element) => element.type == 2);
            if (postList.isEmpty) {
              return const Center(
                  child: Text(
                "게시물이 없어요!",
                style: TextStyle(
                    fontWeight: FontWeight.w300, color: Color(0xff595959)),
              ));
            } else {
              return ListView.builder(
                  itemCount: postList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: () {
                          print(postList[index].pId);
                          Get.to(() => BoardDetailPage(
                                pId: postList[index].pId,
                              ));
                        },
                        child: Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Color(0xffd9d9d9)),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(children: [
                              Container(
                                  height: 60.0,
                                  width: double.infinity,
                                  margin: const EdgeInsets.fromLTRB(
                                      8.0, 8.0, 8.0, 0.0),
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5.0),
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
                                                style: const TextStyle(
                                                    color: Color(0xff595959),
                                                    fontSize: 13.5,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                "3/${postList[index].person}",
                                                style: const TextStyle(
                                                    fontSize: 12.0,
                                                    color: Color(0xff3ac7e7),
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                                style: const TextStyle(
                                                    color: Color(0xff999999),
                                                    fontSize: 12.0,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                              Text(
                                                postList[index].createdAt,
                                                style: const TextStyle(
                                                  fontSize: 12.0,
                                                  color: Color(0xff595959),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )))
                            ])));
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
