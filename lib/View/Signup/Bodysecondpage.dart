//LOGIN BODY

import 'package:get/get.dart';
import 'package:getfix/Controller/linkapi.dart';
import 'package:getfix/View/Clientdashboard/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:getfix/Controller/Apicaller.dart';
import 'package:getfix/View/LogIn/LoginPage.dart';
import 'package:getfix/constants/constant.dart';

class Bodysecondpage extends StatefulWidget {
  @override
  _BodysecondpageState createState() => _BodysecondpageState();
}

class _BodysecondpageState extends State<Bodysecondpage> {
  Apicaller apicaller = new Apicaller();
  Text usernamehint = LocaleText("username");
  Text passwordhint = LocaleText("pasword");
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _username = new TextEditingController();
  final TextEditingController _phonenumber = new TextEditingController();
  String msgStatus = '';
  bool signuppressed = false;

  signup(Size size) async {
    if (checkfieldformat()) {
      setState(() {
        signuppressed = true;
      });

      var response = await apicaller.postrequest(registerlink, {
        "username": _username.text,
        "email": _emailController.text,
        "password": _passwordController.text,
        "phone_num": _phonenumber.text
      });
      try {
        if (response['message'] == "successfully") {
          setState(() {
            signuppressed = false;
          });
          Get.off(Dashboard());
        }
      } catch (e) {
        setState(() {
          signuppressed = false;
          msgStatus = "this user is already exist";
        });

        /// print(response['message']);
      }
    } else {
      setState(() {
        msgStatus = Locales.string(context, "msgemptystate");
      });
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
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty)
      return false;
    return true;
  }

  Container middlebox(Size size) {
    return middleboxoutline(size);
  }

  Container middleboxoutline(Size size) {
    return Container(
      width: size.width * 0.80,
      height: size.height * 0.60,
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
        username(size),
        Manger().sizedBox(0, 0.02, context),

        email(size),
        Manger().sizedBox(0, 0.02, context),

        //padding2(size, 0.02),
        password(size),
        Manger().sizedBox(0, 0.02, context),

        //padding2(size, 0.02),
        //signinmethod(size),
        phonenumber(size),
        Padding(padding: EdgeInsets.all(5)),

        signupbutton(size),
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
        //changesigninmethod(size)
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

  Container password(Size size) {
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
                Icons.vpn_key,
                color: ksecondrycolor,
              ),
              hintText: Locales.string(context, "enterpass"),
              hintStyle: TextStyle(
                  fontSize: 14.0, height: 2.0, color: Colors.grey[600])),
          controller: _passwordController,
          textAlign: TextAlign.start,
          keyboardType: TextInputType.visiblePassword),
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
            hintText: Locales.lang == "en"
                ? "Enter Phone number"
                : "ادخل رقم الموبايل ",
            hintStyle: TextStyle(
                fontSize: 14.0, height: 2.0, color: Colors.grey[600])),
        controller: _phonenumber,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.number,
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
          onPressed: () async {
            await signup(size);
          }),
    );
  }

  Container username(Size size) {
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
            hintText: Locales.lang == "en" ? "User name" : "اسم المستخدم",
            hintStyle: TextStyle(
                fontSize: 14.0, height: 2.0, color: Colors.grey[600])),
        controller: _username,
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
      height: size.height * 0.2,
      alignment: Alignment.center,
    );
  }
}
