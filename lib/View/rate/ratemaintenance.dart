import 'package:getfix/Mywidgits/Floatingbutton.dart';
import 'package:getfix/Mywidgits/MainAppBar.dart';
import 'package:getfix/View/rate/ratemaintenancebody.dart';
import 'package:flutter/material.dart';
import 'package:getfix/constants/Watermark.dart';
import 'package:getfix/constants/constant.dart';
import 'package:getfix/constants/MyDrawer.dart';

class Ratemaintenance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: MainAppBar(),
      /*dashboardappbar().Appbarwigit(context),*/
      /*appBar: AppBar(
          backgroundColor: kprimarycolor,
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(18),
            ),
          ),
          elevation: 10,
          automaticallyImplyLeading: false,
          toolbarHeight: size.height * 0.1,
          title: LocaleText("rate",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: kbackground, fontWeight: FontWeight.bold))),
      */
      body: Stack(
        children: [
          Container(
            alignment: AlignmentDirectional.bottomCenter,
            child: Watermark(),
          ),
          Ratemaintenancebody(),
        ],
      ),
      //drawerEdgeDragWidth: MediaQuery.of(context).size.width,
      drawer: MyDrawer(),
      floatingActionButton: Floatingbutton(),
    );
  }
}
