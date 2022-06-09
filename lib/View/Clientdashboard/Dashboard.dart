import 'package:flutter/material.dart';
import 'package:getfix/Mywidgits/Floatingbutton.dart';
import 'package:getfix/Mywidgits/MainAppBar.dart';
import 'package:getfix/constants/Watermark.dart';
import 'package:getfix/constants/constant.dart';
import 'package:getfix/constants/MyDrawer.dart';
import 'package:getfix/View/Clientdashboard/dashboardBody.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kprimarycolor.withAlpha(50),
      /*dashboardappbar().Appbarwigit(context),*/
      //appBar: dashboardappbar().Appbarwigit(context),
      appBar: MainAppBar(), //Customeappbar(),
      drawer: MyDrawer(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Floatingbutton(),
      body: Stack(
        children: [
          Container(
            alignment: AlignmentDirectional.bottomCenter,
            child: Watermark(),
          ),
          Dashboardbody(),
        ],
      ),
      drawerEnableOpenDragGesture: true,
      drawerEdgeDragWidth: MediaQuery.of(context).size.width,
    );
  }
}
