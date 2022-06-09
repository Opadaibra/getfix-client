import 'package:getfix/Mywidgits/Floatingbutton.dart';
import 'package:getfix/Mywidgits/MainAppBar.dart';
import 'package:getfix/View/Usertutorialguide/Usertutorialguidebody.dart';
import 'package:getfix/constants/constant.dart';
import 'package:getfix/constants/MyDrawer.dart';
import 'package:flutter/material.dart';
import 'package:getfix/constants/Watermark.dart';

class Usertutorialguide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = Manger().getsize(context);
    Color primary = kprimarycolor;
    Color secondary = ksecondrycolor;
    Color backgroundcolor = kbackground;
    return Scaffold(
      floatingActionButton: Floatingbutton(),

      /*dashboardappbar().Appbarwigit(context),*/
      //appBar: dashboardappbar().Appbarwigit(context),
      appBar: MainAppBar(), //Customeappbar(),

      body: Stack(
        children: [
          Container(
            alignment: AlignmentDirectional.bottomCenter,
            child: Watermark(),
          ),
          Usertutorialguidebody(),
        ],
      ),
      drawerEnableOpenDragGesture: true,
      drawerEdgeDragWidth: MediaQuery.of(context).size.width,

      drawer: MyDrawer(),
    );
  }
}
