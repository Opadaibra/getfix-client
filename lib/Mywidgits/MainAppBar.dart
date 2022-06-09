import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getfix/constants/constant.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  MainAppBar({Key? key})
      : preferredSize = Size.fromHeight(Get.height * 0.16),
        super(key: key);
  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset(
        whitGetFix,
        width: Get.size.width * 0.6,
      ),
      centerTitle: true,
      backgroundColor: kprimarycolor,
      toolbarHeight: Get.size.height * 0.15,
      automaticallyImplyLeading: false,
      elevation: 0,
    );
  }
}
