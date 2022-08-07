import 'package:getfix/Mywidgits/Floatingbutton.dart';
import 'package:getfix/Mywidgits/MainAppBar.dart';
import 'package:getfix/View/maintnancerequest/maintnancerequestBody.dart';
import 'package:flutter/material.dart';
import 'package:getfix/constants/constant.dart';
import 'package:getfix/constants/MyDrawer.dart';

class Maintnancerequest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      body: MaintnancerequestBody(),
      
      //drawerEdgeDragWidth: MediaQuery.of(context).size.width,
      drawer: MyDrawer(),        floatingActionButton: Floatingbutton(),

    );
  }
}
