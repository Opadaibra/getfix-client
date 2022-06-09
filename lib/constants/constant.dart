import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

int customer_id =0;
////////////////////////////////////
Color kprimarycolor = Color(0xFF37506C);
Color ksecondrycolor = Color(0xFFFF715A);
Color kdefaultshadow = Colors.black12;
Color kbackground = Colors.white;
Color kerror = Colors.red;
////////////////////////////////////
TextStyle khintstyle = TextStyle(color: Colors.grey, fontSize: 14);
TextStyle draweritemstyle =
    TextStyle(color: kbackground, fontSize: 14, fontWeight: FontWeight.bold);
TextStyle Headlinestyle =
    TextStyle(color: kbackground, fontSize: 16, fontWeight: FontWeight.bold);

TextStyle dialogbuttonstyle =
    TextStyle(color: kprimarycolor, fontSize: 16, fontWeight: FontWeight.bold);
///////////////////////////////////
Image GreenGetFix = Image.asset("Images/GreenGetFix.png");
Image OrnageGetFix = Image.asset("Images/GetFix.png");
String whitGetFix = "Images/whiteGetFix.png";
BoxDecoration kboxdecoration = BoxDecoration(
    border: Border.all(color: ksecondrycolor, width: 1),
    color: kbackground,
    boxShadow: [
      BoxShadow(
        blurRadius: 20,
        spreadRadius: 10,
        offset: Offset(0, 10),
        color: kdefaultshadow,
      )
    ],
    borderRadius: BorderRadius.horizontal(
        left: Radius.circular(kdefaultradius),
        right: Radius.circular(kdefaultradius)));
BoxDecoration sendbuttondecoration = BoxDecoration(boxShadow: [
  BoxShadow(
      blurRadius: 20,
      spreadRadius: 5,
      color: kdefaultshadow,
      offset: Offset(0, 10))
]);
ButtonStyle buttonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(kprimarycolor),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(kdefaultradius),
      side: BorderSide(
        color: kprimarycolor,
        width: .5,
      ),
    ),
  ),
);

var buttonmargen = EdgeInsets.symmetric(horizontal: 70);
LocaleText buttontext = LocaleText(
  "send",
  style: TextStyle(color: kbackground, fontSize: 12),
  textAlign: TextAlign.center,
);
Padding Verticaldefaultpadding =
    Padding(padding: EdgeInsets.symmetric(vertical: kdefaultpadding));
Padding Horizontaldefaultpadding =
    Padding(padding: EdgeInsets.symmetric(horizontal: kdefaultpadding));

var defaultmargin = EdgeInsets.symmetric(horizontal: kdefaultpadding);
int userid = 0;
Padding defaultpadd = Padding(padding: EdgeInsets.all(10));
String innerGreenGetFix = "Images/whiteinnerGetFix.png";

double kdefaultpadding = 20.0;
double kdefaultradius = 36.0;

class Manger {
  TextStyle styleofText(Color color, bool isshadow, double fontsize,
      BuildContext context, bool isbold) {
    return TextStyle(
      color: color,
      fontSize: fontsize,
      fontWeight: isbold ? FontWeight.bold : FontWeight.normal,
      shadows: isshadow ? [Shadow(blurRadius: 0, offset: Offset(1, 1))] : null,
    );
  }

  SizedBox sizedBox(double width, double height, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(width: size.width * width, height: size.height * height);
  }

  bool getx(bool x) {
    return x;
  }

  Size getsize(BuildContext context) {
    return MediaQuery.of(context).size;
  }
}

/* 
final containersbackground = Colors.white;
final hidline1textstyle = TextStyle(
  color: secondarycolor,
  fontSize: 20,
  fontWeight: FontWeight.bold,
  fontFamily: 'SmoochSans',
  shadows: [Shadow(blurRadius: 20, color: Colors.grey, offset: Offset(5, 5))],
);
final hidline3textStyle = TextStyle(
  color: secondarycolor,
  fontSize: 12,
  fontWeight: FontWeight.bold,
  fontFamily: 'SmoochSans',
  shadows: [Shadow(blurRadius: 10, color: Colors.grey, offset: Offset(5, 5))],
);
final hidline4textStyle = TextStyle(
  color: secondarycolor,
  fontSize: 12,
  //fontWeight: FontWeight.bold,
  fontFamily: 'SmoochSans',
  // shadows: [Shadow(blurRadius: 10, color: Colors.grey, offset: Offset(5, 5))],
);
final hintStyle = TextStyle(
    color: Colors.grey,
    fontSize: 12,
    fontWeight: FontWeight.bold,
    letterSpacing: 1);
final buttontext = TextStyle(
    color: containersbackground, fontSize: 15, fontWeight: FontWeight.bold);
final whitebuttontext =
    TextStyle(color: secondarycolor, fontSize: 15, fontWeight: FontWeight.bold);
final pincodestyle =
    TextStyle(color: secondarycolor, fontSize: 25, fontWeight: FontWeight.bold);
*/