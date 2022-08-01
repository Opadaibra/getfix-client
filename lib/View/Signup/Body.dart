//LOGIN BODY

import 'package:get/get.dart';
import 'package:getfix/Controller/linkapi.dart';
import 'package:getfix/View/Clientdashboard/Dashboard.dart';
import 'package:intl/intl.dart';
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

  final TextEditingController _firstname = new TextEditingController();
  final TextEditingController _lastname = new TextEditingController();
  String msgStatus = '';
  bool signuppressed = false;
  DateTime _dateTime = DateTime.now();
  DateTime enddate = DateTime.now();
  var pickeddate;
  creataccount(Size size) async {
    if (checkfieldformat()) {
      setState(() {
        signuppressed = true;
      });
      //print( _phonenumber.text)
      var response = await apicaller.postrequest(addcustomerlink, {
        "phone": myphonenumber,
        "email": myemail,
        "f_name": _firstname.text,
        "l_name": _lastname.text,
        "birth": pickeddate.toString(),
      });
      SharedPreferences preferences = await SharedPreferences.getInstance();
      print(response);
      print(signuppressed);

      if (response["message"] == "succes") {
        var secondrspon = response["id"];
        print(secondrspon["id"]);
        setState(() {
          customer_id = secondrspon["id"];
          signuppressed = false;
          preferences.setInt("customerid", customer_id);
          Get.off(Dashboard());
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
  void initState() {
    // TODO: implement initState
    getphoneandemail();
  }

  String myphonenumber = "null";
  String myemail = "null";
  getphoneandemail() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    try {
      myphonenumber = pre.getString("phonenumber")!;
      myemail = pre.getString("email")!;
      print(myphonenumber);
      print(myemail);
    } catch (e) {}
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
          Manger().sizedBox(0, 0.1, context),
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
    if (_firstname.text.isEmpty ||
        _lastname.text.isEmpty ||
        myemail == "null" ||
        myphonenumber == "null") return false;
    return true;
  }

  Center middlebox(Size size) {
    return middleboxoutline(size);
  }

  Center middleboxoutline(Size size) {
    return Center(
      child: Container(
        width: size.width * 0.80,
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
      ),
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

        //padding2(size, 0.02),
        birthday(size),
        Manger().sizedBox(0, 0.02, context),

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

        // forgotpassword(size),1
        //singinthrow(),
        // changesigninmethod(size),

        Padding(padding: EdgeInsets.all(10)),
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
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(30)),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now())
                      .then((value) {
                    setState(() {
                      _dateTime = value!;
                      pickeddate = DateFormat('dd/MM/yyyy').format(_dateTime);
                      print("asdsa:${pickeddate.toString()}");
                    });
                  });
                },
                icon: Icon(Icons.date_range_outlined),
                color: ksecondrycolor,
              ),
              Text(pickeddate == null ? "pick your birthdate" : pickeddate),
            ],
          ),
        ));
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
                "signup",
                style: Manger().styleofText(
                    kbackground, false, size.width * 0.04, context, true),
              ),
        onPressed: () async {
          await creataccount(size);
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

  Container topImage(Size size) {
    return Container(
      child: OrnageGetFix,
      width: size.width,
      height: size.height * 0.1,
      alignment: Alignment.center,
    );
  }
}
