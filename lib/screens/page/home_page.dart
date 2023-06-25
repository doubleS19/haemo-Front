import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:hae_mo/screens/Page/recommend_page.dart';
import 'package:hae_mo/screens/page/posting_page.dart';
import '../../model/shared_preference.dart';
import 'club_page.dart';
import 'club_posting_page.dart';
import 'meeting_page.dart';
import 'my_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const MeetingPage(),
    const ClubPage(),
    const RecommendPage(),
    const MyPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.only(left: 2.0, right: 2.0),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  topLeft: Radius.circular(15.0)),
              boxShadow: [
                BoxShadow(
                    color: Color(0xff3ac7e7),
                    spreadRadius: 2.0,
                    blurRadius: 0.0)
              ]),
          child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  topLeft: Radius.circular(15.0)),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
                  BottomNavigationBarItem(icon: Icon(Icons.group), label: ""),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.location_on), label: ""),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: ""),
                ],
                currentIndex: _selectedIndex,
                unselectedItemColor: const Color(0xffadadad),
                selectedItemColor: const Color(0xff3ac7e7),
                onTap: _onItemTapped,
              )),
        ),
        floatingActionButton: floatingButton());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget? floatingButton() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.add_event,
      visible: true,
      curve: Curves.bounceIn,
      foregroundColor: Colors.white,
      backgroundColor: const Color(0xff3ac7e7),
      children: [
        SpeedDialChild(
          label: "핫플 글쓰기",
          labelStyle: const TextStyle(
              fontWeight: FontWeight.w500, color: Colors.white, fontSize: 13.0),
          labelBackgroundColor: const Color(0xff3ac7e7),
          onTap: () {
            PreferenceUtil.remove("id");
            Get.to(() => const PostingPage());
          },
        ),
        SpeedDialChild(
          label: "소모임 글쓰기",
          labelStyle: const TextStyle(
              fontWeight: FontWeight.w500, color: Colors.white, fontSize: 13.0),
          labelBackgroundColor: const Color(0xff3ac7e7),
          onTap: () {
            Get.to(() => const ClubPostingPage());
          },
        ),
        SpeedDialChild(
          label: "새 글쓰기",
          labelStyle: const TextStyle(
              fontWeight: FontWeight.w500, color: Colors.white, fontSize: 13.0),
          labelBackgroundColor: const Color(0xff3ac7e7),
          onTap: () {
            Get.to(() => const PostingPage());
          },
        ),
      ],
    );
  }
}
