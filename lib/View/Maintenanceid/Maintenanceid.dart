import 'package:flutter/material.dart';
import 'package:getfix/Mywidgits/Floatingbutton.dart';
import 'package:getfix/Mywidgits/MainAppBar.dart';
import 'package:getfix/constants/constant.dart';
import 'package:getfix/constants/MyDrawer.dart';
import 'package:getfix/View/Maintenanceid/Maintenanceidbody.dart';

class Maintenanceid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(), //Customeappbar(),
      body: Maintenanceidbody(),
      floatingActionButton: Floatingbutton(),
      drawerEdgeDragWidth: MediaQuery.of(context).size.width,
      drawer: MyDrawer(),
      
    );
  }
}
