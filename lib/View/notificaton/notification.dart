import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:getfix/Mywidgits/Floatingbutton.dart';
import 'package:getfix/constants/Watermark.dart';
import 'package:getfix/constants/constant.dart';
import 'package:getfix/constants/MyDrawer.dart';
import 'package:getfix/View/notificaton/notificatinbody.dart';

class MyyNotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = Manger().getsize(context);

    return Scaffold(
      /*dashboardappbar().Appbarwigit(context),*/ floatingActionButton:
          Floatingbutton(),
      appBar: AppBar(
          backgroundColor: kprimarycolor,
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          automaticallyImplyLeading: true,
          toolbarHeight: size.height * 0.1,
          title: LocaleText("notifi",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: kbackground, fontWeight: FontWeight.bold))),
      body: Stack(
        children: [
          Container(
            alignment: AlignmentDirectional.bottomCenter,
            child: Watermark(),
          ),
          Notificatinbody(),
        ],
      ),
      drawerEdgeDragWidth: MediaQuery.of(context).size.width,
      drawer: MyDrawer(),
    );
  }
}
