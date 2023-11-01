import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hae_mo/controller/app_version_controller.dart';
import 'package:package_info/package_info.dart';
import 'package:yaml/yaml.dart';
import '../../components/customAppBar.dart';

class AppVersionPage extends StatefulWidget {
  AppVersionPage({Key? key}) : super(key: key);
  @override
  State<AppVersionPage> createState() => _AppVersionPageState();
}

class _AppVersionPageState extends State<AppVersionPage> {
  final AppVersionController controller = Get.put(AppVersionController());

  @override
  void initState() {
    super.initState();
    controller.fetchAppVersion();
  }

  @override
  Widget build(BuildContext context) {
    controller.fetchAppVersion();
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Builder(
            builder: (context) => customColorAppbar(context, "앱 버전"),
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
          child: Obx(() {
            final version = controller.version.value;
            return Text("앱 버전: $version");
          }),
        )));
  }
}
