//dashboard BODY

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Notificatinbody extends StatefulWidget {
  @override
  _NotificatinbodyState createState() => _NotificatinbodyState();
}

class _NotificatinbodyState extends State<Notificatinbody> {
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(),
    );
  }

  Padding padding2(Size size, double decrease) =>
      Padding(padding: EdgeInsets.only(top: size.height * decrease));
}
