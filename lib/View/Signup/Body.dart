//LOGIN BODY

import 'package:get/get.dart';
import 'package:getfix/Controller/linkapi.dart';
import 'package:getfix/View/Clientdashboard/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:getfix/Controller/Apicaller.dart';
import 'package:getfix/View/LogIn/LoginPage.dart';
import 'package:getfix/View/Signup/SignUpPageseconde.dart';
import 'package:getfix/constants/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Apicaller apicaller = new Apicaller();
  Text usernamehint = LocaleText("username");
  Text passwordhint = LocaleText("pasword");
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _birthdateController =
      new TextEditingController();
  final TextEditingController _firstname = new TextEditingController();
  final TextEditingController _lastname = new TextEditingController();
  final TextEditingController _phonenumber = new TextEditingController();
  String msgStatus = '';
  bool signuppressed = false;

  next(Size size) async {
    if (checkfieldformat()) {
      setState(() {
        signuppressed = true;
      });
      //print( _phonenumber.text)
      var response = await apicaller.postrequest(addcustomerlink, {
        "phone": _phonenumber.text,
        "email": _emailController.text,
        "f_name": _firstname.text,
        "l_name": _lastname.text,
        "birth": _birthdateController.text,
      });
      SharedPreferences preferences = await SharedPreferences.getInstance();

      if (response["message"] == "succes") {
        var secondrspon = response["id"];
        print(secondrspon["id"]);
        setState(() {
          customer_id = secondrspon["id"];
          signuppressed = false;
          preferences.setInt("customerid", customer_id);
          Get.to(SecondSignUpPage());
        });
      } else if (response["message"] == "Not Valid") {
        setState(() {
          signuppressed = false;
          msgStatus = "Invaled information";
        });
      }

      // try {
      //   if (response['message'[0]])
      //     setState(() {
      //       signuppressed = false;
      //     });
      //   print("ID: $customer_id");
      // } catch (e) {
      //   if (response["phone"]) {
      //     setState(() {
      //       signuppressed = false;
      //       msgStatus = response["phone"][0].toString();
      //     });
      //   } else {setState(() {

      //   });
      //   }
      // }

      /// print(response['message']);

    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = Manger().getsize(context);
    return Container(
        //    alignment: Alignment.center,
        child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          boxpadding(size),
          topImage(size),
          boxpadding(size),
          middlebox(size),
          boxpadding(size),
          sigin(size)
        ],
      ),
    ));
  }

  SizedBox boxpadding(Size size) {
    return SizedBox(
      height: size.height * 0.02,
    );
  }

  Padding padding2(Size size, double decreasrate) =>
      Padding(padding: EdgeInsets.only(top: size.height * decreasrate));

  Container sigin(Size size) {
    return Container(
      padding: EdgeInsets.all(size.width * 0.05),
      width: size.width * 0.5,
      // ignore: deprecated_member_use
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kbackground),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(
                  color: ksecondrycolor,
                  width: 2.0,
                ),
              ),
            ),
          ),
          child: LocaleText(
            'sign',
            style:
                Manger().styleofText(kprimarycolor, false, 12, context, true),
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            setState(() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            });
          }),
    );
  }

  bool checkfieldformat() {
    if (_emailController.text.isEmpty ||
        _birthdateController.text.isEmpty ||
        _firstname.text.isEmpty ||
        _lastname.text.isEmpty ||
        _phonenumber.text.isEmpty) return false;
    return true;
  }

  Container middlebox(Size size) {
    return middleboxoutline(size);
  }

  Container middleboxoutline(Size size) {
    return Container(
      width: size.width * 0.80,
      height: size.height * 0.70,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              //    color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 10,
              offset: Offset(0, 15),
              color: Colors.black26
              // changes position of shadow
              ),
        ],
        color: kbackground,
        border: Border.all(
          width: 0.1,
        ),
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      child: middleboxentites(size),
    );
  }

  Column middleboxentites(Size size) {
    return Column(
      children: [
        padding2(size, 0.01),
        LocaleText(
          "signup",
          style: Manger().styleofText(kprimarycolor, false, 25, context, false),
          //  textAlign: TextAlign.center,
        ),
        // Padding(padding: EdgeInsets.all(size.height * 0.02)),
        Manger().sizedBox(0, 0.02, context),
        firstname(size),
        Manger().sizedBox(0, 0.02, context),
        lastname(size),
        Manger().sizedBox(0, 0.02, context),
        email(size),
        Manger().sizedBox(0, 0.02, context),

        //padding2(size, 0.02),
        birthday(size),
        Manger().sizedBox(0, 0.02, context),

        //padding2(size, 0.02),
        //signinmethod(size),
        phonenumber(size),
        Padding(padding: EdgeInsets.all(5)),

        nextbutton(size),
        Padding(padding: EdgeInsets.all(5)),

        Container(
          //height: size.height * 0.01,
          child: new Text(
            '$msgStatus',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, color: kerror),
          ),
        ),
        Padding(padding: EdgeInsets.all(2)),

        // forgotpassword(size),1
        //singinthrow(),
        changesigninmethod(size)
        //singinthrow(),
        // Padding(padding: EdgeInsets.all(size.height * 0.01)),
        //changesigninmethod(size),
        //Padding(padding: EdgeInsets.all(size.height * 0.01)),
      ],
    );
  }

  Container singinthrow() {
    return Container(
      child: LocaleText(
        "singupthrow",
        textAlign: TextAlign.center,
      ),
    );
  }

  // ignore: deprecated_member_use
  FlatButton forgotpassword(Size size) {
    // ignore: deprecated_member_use
    return FlatButton(
      onPressed: null,
      child: LocaleText(
        "forgotpassword",
        style: Manger().styleofText(
            kprimarycolor, false, size.width * 0.04, context, true),
      ),
    );
  }

  Container changesigninmethod(Size size) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ignore: deprecated_member_use
          FlatButton(
            onPressed: null,
            child: Icon(
              Icons.email,
              size: size.width * 0.1,
              color: Colors.red[400],
            ),
          ),
          // ignore: deprecated_member_use
          FlatButton(
              onPressed: null,
              child: Icon(
                Icons.facebook,
                size: size.width * 0.1,
                color: Colors.blue,
              ))
        ],
      ),
    );
  }

  Container birthday(Size size) {
    return Container(
      width: size.width * 0.75,
      //height: size.height * 0.06,
      child: TextField(
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: new BorderSide(
                  width: 2.0,
                  color: kbackground,
                  //style: BorderStyle.solid
                ),
                borderRadius: new BorderRadius.all(Radius.circular(120)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: new BorderSide(
                  width: 2.0,
                  color: kbackground,
                  //style: BorderStyle.solid
                ),
                borderRadius: new BorderRadius.all(Radius.circular(120)),
              ),
              filled: true,
              fillColor: Colors.grey[80],
              contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
              prefixIcon: Icon(
                Icons.date_range_outlined,
                color: ksecondrycolor,
              ),
              hintText: Locales.lang == "en"
                  ? "Birth date dd/mm/yy"
                  : "تاريخ الميلاد يوم/شهر/سنة",
              hintStyle: TextStyle(
                  fontSize: 14.0, height: 2.0, color: Colors.grey[600])),
          controller: _birthdateController,
          textAlign: TextAlign.start,
          keyboardType: TextInputType.text),
    );
  }

  Container phonenumber(Size size) {
    return Container(
      width: size.width * 0.75,
      //height: size.height * 0.06,
      child: TextField(
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: new BorderSide(
                width: 2.0,
                color: kbackground,
                //style: BorderStyle.solid
              ),
              borderRadius: new BorderRadius.all(Radius.circular(120)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: new BorderSide(
                width: 2.0,
                color: kbackground,
                //style: BorderStyle.solid
              ),
              borderRadius: new BorderRadius.all(Radius.circular(120)),
            ),
            filled: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
            fillColor: Colors.grey[80],
            prefixIcon: Icon(
              Icons.phone,
              color: ksecondrycolor,
            ),
            hintText: Locales.lang == "en" ? " Phone number" : " رقم الموبايل ",
            hintStyle: TextStyle(
                fontSize: 14.0, height: 2.0, color: Colors.grey[600])),
        controller: _phonenumber,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.number,
      ),
    );
  }

  Container nextbutton(Size size) {
    return Container(
      width: size.width * 0.65,
      height: size.height * 0.06,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            ksecondrycolor,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(
                color: kbackground,
                width: .5,
              ),
            ),
          ),
        ),
        child: signuppressed
            ? CircularProgressIndicator(
                color: kbackground,
              )
            : LocaleText(
                "next",
                style: Manger().styleofText(
                    kbackground, false, size.width * 0.04, context, true),
              ),
        onPressed: () async {
          await next(size);
        },
        onLongPress: () => Get.to(SecondSignUpPage()),
      ),
    );
  }

  Container signupbutton(Size size) {
    return Container(
        width: size.width * 0.65,
        height: size.height * 0.06,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              ksecondrycolor,
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(
                  color: kbackground,
                  width: .5,
                ),
              ),
            ),
          ),
          child: signuppressed
              ? CircularProgressIndicator(
                  color: kbackground,
                )
              : LocaleText(
                  "signup",
                  style: Manger().styleofText(
                      kbackground, false, size.width * 0.04, context, true),
                ),
          onPressed: null,
        ));
  }

  Container firstname(Size size) {
    return Container(
      width: size.width * 0.75,
      //  height: size.height * 0.06,
      child: TextField(
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: new BorderSide(
                width: 2.0,
                color: kbackground,
                //style: BorderStyle.solid
              ),
              borderRadius: new BorderRadius.all(Radius.circular(120)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: new BorderSide(
                width: 2.0,
                color: kbackground,
                //style: BorderStyle.solid
              ),
              borderRadius: new BorderRadius.all(Radius.circular(120)),
            ),
            filled: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
            fillColor: Colors.grey[80],
            prefixIcon: Icon(
              Icons.person,
              color: ksecondrycolor,
            ),
            hintText: Locales.lang == "en" ? "First Name" : "الاسم الأول",
            hintStyle: TextStyle(
                fontSize: 14.0, height: 2.0, color: Colors.grey[600])),
        controller: _firstname,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.name,
      ),
    );
  }

  Container lastname(Size size) {
    return Container(
      width: size.width * 0.75,
      //  height: size.height * 0.06,
      child: TextField(
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: new BorderSide(
                width: 2.0,
                color: kbackground,
                //style: BorderStyle.solid
              ),
              borderRadius: new BorderRadius.all(Radius.circular(120)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: new BorderSide(
                width: 2.0,
                color: kbackground,
                //style: BorderStyle.solid
              ),
              borderRadius: new BorderRadius.all(Radius.circular(120)),
            ),
            filled: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
            fillColor: Colors.grey[80],
            prefixIcon: Icon(
              Icons.person,
              color: ksecondrycolor,
            ),
            hintText: Locales.lang == "en" ? "last Name" : "الاسم الأخير",
            hintStyle: TextStyle(
                fontSize: 14.0, height: 2.0, color: Colors.grey[600])),
        controller: _lastname,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.name,
      ),
    );
  }

  Container email(Size size) {
    return Container(
      width: size.width * 0.75,
      //height: size.height * 0.06,
      child: TextField(
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: new BorderSide(
                width: 2.0,
                color: kbackground,
                //style: BorderStyle.solid
              ),
              borderRadius: new BorderRadius.all(Radius.circular(120)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: new BorderSide(
                width: 2.0,
                color: kbackground,
                //style: BorderStyle.solid
              ),
              borderRadius: new BorderRadius.all(Radius.circular(120)),
            ),
            filled: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
            fillColor: Colors.grey[80],
            prefixIcon: Icon(
              Icons.mail_outline_rounded,
              color: ksecondrycolor,
            ),
            hintText: Locales.lang == "en" ? "email" : "البريد الالكتروني",
            hintStyle: TextStyle(
                fontSize: 14.0, height: 2.0, color: Colors.grey[600])),
        controller: _emailController,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  Container topImage(Size size) {
    return Container(
      child: OrnageGetFix,
      width: size.width,
      height: size.height * 0.1,
      alignment: Alignment.center,
    );
  }
}
