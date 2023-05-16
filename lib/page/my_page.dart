import 'package:flutter/material.dart';
import 'package:hae_mo/model/shared_preference.dart';
import 'package:hae_mo/model/user_model.dart';
import 'package:hae_mo/model/user_response_model.dart';
import 'package:hae_mo/service/db_service.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    DBService db = DBService();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0.0,
          title: const Text(
            "마이 페이지",
            style: TextStyle(
              color: Color(0xff595959),
              fontSize: 19.0,
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Column(children: [
          const Divider(color: Color(0xff595959)),
          FutureBuilder(
              future:
                  db.getUserByNickname(PreferenceUtil.getString("nickname")!),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final UserResponse user = snapshot.data as UserResponse;
                  return Container(
                    width: 360.0,
                    height: 367.0,
                    margin: const EdgeInsets.only(top: 20.0),
                    child: Column(children: [
                      const Text(
                        "프로필",
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Color(0xff818181),
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                            color: const Color(0xffe3e3e3),
                            borderRadius: BorderRadius.circular(15.0)),
                        alignment: Alignment.center,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        user.major,
                        style: const TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        user.nickname,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      const Divider(color: Color(0xff595959)),
                    ]),
                  );
                } else {
                  return Text("회원 정보를 불러오는데 실패했습니다.\n다시 시도해주세요.");
                }
              })
        ]));
  }
}
