import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:getfix/View/addsite/Addsite.dart';
import 'package:getfix/View/checkwarrantystate/Warranty.dart';
import 'package:getfix/constants/constant.dart';
import 'package:getfix/View/maintnancerequest/maintnancerequest.dart';
import 'package:getfix/View/notificaton/notification.dart';
import 'package:getfix/View/rate/ratemaintenance.dart';

class Floatingbutton extends StatelessWidget {
  const Floatingbutton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      backgroundColor: kprimarycolor,
      //  foregroundColor: backgroundcolor.withOpacity(0.25),
      animatedIcon: AnimatedIcons.menu_close,
      //   elevation: 0, direction: SpeedDialDirection.right,
      //onOpen: () => {paddingfloatbutton = true},
      //  childPadding: EdgeInsets.only(left: 50),
      children: [
        SpeedDialChild(
          onTap: () => Get.to(Ratemaintenance()),
          child: Icon(
            Icons.star,
            color: kbackground,
          ),
          backgroundColor: ksecondrycolor,
        ),
        // SpeedDialChild(
        //   onTap: (() => Get.to(MyyNotification())),
        //   child: Icon(
        //     Icons.notifications,
        //     color: kbackground,
        //   ),
        //   backgroundColor: ksecondrycolor,
        // ),
        SpeedDialChild(
          //label: "asds",
          labelStyle: TextStyle(),
          onTap: (() => Get.to(Addsite())),
          child: Icon(
            Icons.location_on_rounded,
            color: kbackground,
          ),
          backgroundColor: ksecondrycolor,
        ),
        // SpeedDialChild(
        //   onTap: (() => Get.to(Maintnancerequest())),
        //   child: Icon(
        //     Icons.precision_manufacturing_rounded,
        //     color: kbackground,
        //   ),
        //   backgroundColor: ksecondrycolor,
        // ),
        SpeedDialChild(
          onTap: (() => Get.to(Warranty())),
          labelStyle: TextStyle(),
          child: Icon(
            Icons.qr_code,
            color: kbackground,
          ),
          backgroundColor: ksecondrycolor,
        ),
      ],
    );
  }
}
