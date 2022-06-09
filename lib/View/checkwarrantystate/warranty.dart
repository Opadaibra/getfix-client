import 'package:flutter/material.dart';
import 'package:getfix/Mywidgits/Floatingbutton.dart';
import 'package:getfix/Mywidgits/MainAppBar.dart';
import 'package:getfix/View/checkwarrantystate/warrantystatebody.dart';
import 'package:getfix/constants/Watermark.dart';
import 'package:getfix/constants/MyDrawer.dart';

class Warranty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(        floatingActionButton: Floatingbutton(),

      /*dashboardappbar().Appbarwigit(context),*/
      appBar: MainAppBar(), //Customeappbar(),
      body: Stack(
        children: [
          Container(
            alignment: AlignmentDirectional.bottomCenter,
            child: Watermark(),
          ),
          warrantystatebody(),
        ],
      ),
      drawerEdgeDragWidth: MediaQuery.of(context).size.width,
      drawer: MyDrawer(),
    );
  }
}
