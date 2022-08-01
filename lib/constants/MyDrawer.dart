import 'package:get/get.dart';
import 'package:getfix/View/LogIn/LoginPage.dart';
import 'package:getfix/View/Maintenanceid/Maintenanceid.dart';
import 'package:getfix/View/Usertutorialguide/Usertutorialguide.dart';
import 'package:getfix/View/addsite/Addsite.dart';
import 'package:getfix/View/checkwarrantystate/warranty.dart';
import 'package:getfix/View/maintnancerequest/maintnancerequest.dart';
import 'package:getfix/View/rate/ratemaintenance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:getfix/Settings/Settings.dart';
import 'package:getfix/View/showproduct/showproducts.dart';
import 'package:getfix/constants/constant.dart';
import 'package:getfix/View/Clientdashboard/Dashboard.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  MyDrawerState createState() => MyDrawerState();
}

class MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.size.width * 0.80,
        child: ClipRRect(
          borderRadius: Locales.lang == "ar"
              ? BorderRadiusDirectional.only(
                      topEnd: Radius.circular(30),
                      bottomEnd: Radius.circular(30))
                  .resolve(TextDirection.rtl)
              : BorderRadiusDirectional.only(
                      topEnd: Radius.circular(30),
                      bottomEnd: Radius.circular(30))
                  .resolve(TextDirection.ltr),
          child: Drawer(
            //  elevation: 40,
            child: Container(
              color: kprimarycolor,
              child: Column(
                children: [
                  //DrawerHeader(child: Text("")),
                  useraccountheader(context),
                  //  maintnancerequest(context),
                  // notiticationListtitle(context),
                  //   rateteam(context),
                  showmissions(context),
                  showproducts(context),
                  // checkWarrantyestate(context),
                  //addsite(context),
                  maintenanceid(context),
                  usertutorialgid(context),
                  settings(context),
                  logout(context),
                ],
              ),
            ),
          ),
        ));
  }

  // ListTile notiticationListtitle(BuildContext context) {
  //   return ListTile(
  //       title: LocaleText(
  //         "notifi",
  //         textAlign: TextAlign.start,
  //         style: Manger().styleofText(kbackground, false,
  //            Get.size.width * 0.04, context, true),
  //       ),
  //       leading: Icon(
  //         Icons.notifications,
  //         color: kbackground,
  //       ),
  //       onTap: () {
  //         Navigator.push(
  //             context,
  //             new MaterialPageRoute(
  //                 builder: (context) => new MyyNotification()));
  //       });
  // }

  ListTile showmissions(BuildContext context) {
    return ListTile(
      title: LocaleText(
        "showtasks",
        textAlign: TextAlign.start,
        style: Manger().styleofText(
            kbackground, false, Get.size.width * 0.04, context, true),
      ),
      leading: Icon(
        Icons.home,
        color: kbackground,
      ),
      onTap: () {
        Scaffold.of(context).closeDrawer();
        Get.to(Dashboard());
      },
    );
  }

  ListTile checkWarrantyestate(BuildContext context) {
    return ListTile(
      title: LocaleText(
        "warranty",
        textAlign: TextAlign.start,
        style: Manger().styleofText(
            kbackground, false, Get.size.width * 0.04, context, true),
      ),
      leading: Icon(
        Icons.qr_code,
        color: kbackground,
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => new Warranty()));
      },
    );
  }

  ListTile maintnancerequest(BuildContext context) {
    return ListTile(
      title: LocaleText(
        "maintenancereq",
        textAlign: TextAlign.start,
        style: draweritemstyle,
      ),
      leading: Icon(
        Icons.precision_manufacturing_rounded,
        color: kbackground,
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => new Maintnancerequest()));
      },
    );
  }

  ListTile addsite(BuildContext context) {
    return ListTile(
      title: LocaleText(
        "addsite",
        textAlign: TextAlign.start,
        style: draweritemstyle,
      ),
      leading: Icon(
        Icons.location_on,
        color: kbackground,
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => new Addsite()));
      },
    );
  }

  ListTile usertutorialgid(BuildContext context) {
    return ListTile(
      title: LocaleText(
        "usertut",
        textAlign: TextAlign.start,
        style: draweritemstyle,
      ),
      leading: Icon(
        Icons.help_center_rounded,
        color: kbackground,
      ),
      onTap: () {
        Scaffold.of(context).closeDrawer();

        Get.to(Usertutorialguide());
      },
    );
  }

  ListTile showproducts(BuildContext context) {
    return ListTile(
      title: LocaleText(
        "showprod",
        textAlign: TextAlign.start,
        style: draweritemstyle,
      ),
      leading: Icon(
        Icons.production_quantity_limits,
        color: kbackground,
      ),
      onTap: () {
        Scaffold.of(context).closeDrawer();

        Get.to(Showproducts());
      },
    );
  }

  ListTile maintenanceid(BuildContext context) {
    return ListTile(
      title: LocaleText(
        "maintenanceid",
        textAlign: TextAlign.start,
        style: draweritemstyle,
      ),
      leading: Icon(
        Icons.format_list_numbered_outlined,
        color: kbackground,
      ),
      onTap: () {
        Scaffold.of(context).closeDrawer();

        Get.to(Maintenanceid());
      },
    );
  }

  ListTile rateteam(BuildContext context) {
    return ListTile(
      title: LocaleText(
        "rate",
        textAlign: TextAlign.start,
        style: draweritemstyle,
      ),
      leading: Icon(
        Icons.star_rate_rounded,
        color: kbackground,
      ),
      onTap: () {
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new Ratemaintenance()));
      },
    );
  }

  ListTile settings(BuildContext context) {
    return ListTile(
        title: LocaleText(
          "settings",
          textAlign: TextAlign.start,
          style: draweritemstyle,
        ),
        leading: Icon(
          Icons.settings,
          color: kbackground,
        ),
        onTap: () {
          Scaffold.of(context).closeDrawer();

          Get.to(Settings());
        });
  }

  ListTile logout(BuildContext context) {
    return ListTile(
      title: LocaleText(
        "logout",
        textAlign: TextAlign.start,
        style: draweritemstyle,
      ),
      leading: Icon(
        Icons.logout_rounded,
        color: kbackground,
      ),
      onTap: () {
        Get.defaultDialog(
          content: LocaleText(
            "logoutdialog",
            textAlign: TextAlign.center,
          ),
          cancel: InkWell(
            onTap: () => Get.back(),
            child: LocaleText(
              "cancel",
              style: dialogbuttonstyle,
            ),
          ),
          confirm: InkWell(
            onTap: () => Get.off(LoginPage()),
            child: LocaleText(
              "confirm",
              style: dialogbuttonstyle,
            ),
          ),
        );

        // Get.off(LoginPage());
      },
    );
  }

  UserAccountsDrawerHeader useraccountheader(BuildContext context) {
    return UserAccountsDrawerHeader(
      //currentAccountPictureSize: size * 0.18,
      currentAccountPicture: CircleAvatar(
        backgroundColor: ksecondrycolor,
      ),
      accountName: Text(
        "OpadaIbra",
        textAlign: TextAlign.start,
        style: draweritemstyle,
      ),
      accountEmail: Text(
        "Opadaibra@gmail.com",
        textAlign: TextAlign.left,
        style: draweritemstyle,
      ),
    );
  }
}
