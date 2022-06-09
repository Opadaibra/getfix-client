import 'package:getfix/Mywidgits/Floatingbutton.dart';
import 'package:getfix/Mywidgits/MainAppBar.dart';
import 'package:getfix/View/addsite/Addsitebody.dart';
import 'package:flutter/material.dart';
import 'package:getfix/View/addsite/Addsitebodysecond.dart';
import 'package:getfix/constants/Watermark.dart';
import 'package:getfix/constants/constant.dart';
import 'package:getfix/constants/MyDrawer.dart';

class Addsite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = Manger().getsize(context);
    return Scaffold(
      appBar: MainAppBar(), //ustomeappbar(),
      // dashboardappbar().Appbarwigit(context),
      //sd
      body: Addsitebody(),
      drawerEdgeDragWidth: MediaQuery.of(context).size.width,
      floatingActionButton: Floatingbutton(),

      drawer: MyDrawer(),
    );
  }
}
