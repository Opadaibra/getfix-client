//dashboard BODY

import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/_http/interface/request_base.dart';
import 'package:getfix/Controller/Apicaller.dart';
import 'package:getfix/Controller/linkapi.dart';
import 'package:getfix/Mywidgits/modifedappbar.dart';
import 'package:getfix/constants/constant.dart';

int sitecount = 0;

class Addsitebodysecond extends StatefulWidget {
  @override
  _AddsitebodybodyState createState() => _AddsitebodybodyState();
}

var _selectedgovernorate;
var _selectedcity;
List governorates2 = [];
List<String> mysite = [];

class _AddsitebodybodyState extends State<Addsitebodysecond> {
  // ignore: non_constant_identifier_names
  final TextEditingController _StreetController = new TextEditingController();
  final TextEditingController _buildingaddressController =
      new TextEditingController();
  final TextEditingController _buildingnumberController =
      new TextEditingController();
  final TextEditingController _floornumberController =
      new TextEditingController();
  Apicaller apicaller = new Apicaller();
  bool enabled = true;
  String errormessage = "";
  @override
  void initState() {
    // TODO: implement initState
    print(_selectedgovernorate);
    downloadcity();
  }

  List governorates = [];
  List cities = [];
  @override
  Widget build(BuildContext context) {
    Size size = Manger().getsize(context);

    //List _ad = [LocaleText("")];

    return Column(
      children: [
        modiefedappbar(
            size: size,
            widgiticon: Icon(
              Icons.location_on,
              size: size.width * 0.12,
              color: kbackground,
            ),
            localeText: LocaleText(
              "site",
              style: TextStyle(
                  color: kbackground,
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.05),
            )),
        /* Verticaldefaultpadding,
        Container(
          decoration: kboxdecoration,
          padding: defaultmargin,
          margin: defaultmargin,
          child: Column(
            children: [
              Verticaldefaultpadding,
              governoratechoose(size, governorates, cities),
              Verticaldefaultpadding,
              citychoose(size, cities),
              Verticaldefaultpadding,
            ],
          ),
        ),*/
        body(size, governorates, cities, context),
      ],
    );
  }

  void downloadcity() {
    /*  var respne = apicaller.getrequest(
      get_govling,
    );*/
    setState(() {
      governorates = [""];
    });
  }

  Expanded body(Size size, List<dynamic> governorates, List<dynamic> cities,
      BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          Column(
            children: [
              //header(size, context),

              Verticaldefaultpadding,
              Container(
                decoration: kboxdecoration,
                padding: defaultmargin,
                margin: defaultmargin,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      //  width: size.width * .9,
                      child: TextField(
                        controller: _StreetController,
                        minLines: 1,
                        maxLines: 5,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            hintStyle: khintstyle,
                            hintText: Locales.string(context, "street")
                            // prefixIcon: Icon(Icons.camera_enhance_rounded)
                            ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      // width: size.width * .9,
                      child: TextField(
                        controller: _buildingaddressController,
                        minLines: 1,
                        maxLines: 5,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            hintStyle: khintstyle,
                            hintText: Locales.string(context, "buildingadd")
                            // prefixIcon: Icon(Icons.camera_enhance_rounded)
                            ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      //   width: size.width * .9,
                      child: TextField(
                        controller: _buildingnumberController,
                        minLines: 1,
                        maxLines: 5,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            hintStyle: khintstyle,
                            hintText: Locales.string(context, "buildingno")
                            // prefixIcon: Icon(Icons.camera_enhance_rounded)
                            ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      //  width: size.width * .9,
                      child: TextField(
                        controller: _floornumberController,
                        minLines: 1,
                        maxLines: 5,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            hintStyle: khintstyle,
                            hintText: Locales.string(context, "floorno")
                            // prefixIcon: Icon(Icons.camera_enhance_rounded)
                            ),
                      ),
                    ),
                    Verticaldefaultpadding,
                  ],
                ),
              ),
              Verticaldefaultpadding,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  back(size, context),
                  sendbutton(size, context),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  void updatecity() {
    setState(() {
      cities = ["as", 'asd', 'adas'];
    });
  }

  bool checkinput() {
    if (
        _StreetController.text.isEmpty ||
        _buildingaddressController.text.isEmpty ||
        _buildingnumberController.text.isEmpty ||
        _floornumberController.text.isEmpty) {
      return false;
    }
    return true;
  }

  Container governoratechoose(Size size, List _governorates, List cities) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: kbackground,
          boxShadow: [
            BoxShadow(
                color: kdefaultshadow, blurRadius: 10, offset: Offset(0, 10))
          ]),
      width: size.width * 0.8,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          borderRadius: BorderRadius.circular(18),

          iconEnabledColor: kprimarycolor,
          icon: Icon(
            Icons.expand_circle_down_rounded,
            size: size.width * 0.1,
          ),
          //    menuMaxHeight: size.height * 0.5,
          //itemHeight: size.height * 0.2,
          isExpanded: true,
          style: Manger().styleofText(kprimarycolor, false, 14, context, true),
          value: _selectedgovernorate,
          onChanged: (newvalue) async {
            setState(() {
              _selectedgovernorate = newvalue;
              updatecitylist(cities, _selectedgovernorate);
            });
          },
          items: _governorates.map((governate) {
            return DropdownMenuItem(
              child: Text(
                governate,
                style: TextStyle(wordSpacing: 5),
              ),
              value: governate,
            );
          }).toList(),
          hint: LocaleText(
            "governorate",
            style: TextStyle(color: kprimarycolor),
          ),
        ),
      ),
    );
  }

  void updatecitylist(List cities, var governant) {
    if (governant == Locales.string(context, "dammascus")) {
      print(" حيو الشام لك عمي");
    }
    if (governant == Locales.string(context, "daraa")) {
      print(" ولك عراسي الدراعنة");
    }
    if (governant == Locales.string(context, "homs")) {
      print(" اهلييين والله بحووومص");
    }
  }

  Container citychoose(Size size, List<dynamic> _cities) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: kbackground,
          boxShadow: [
            BoxShadow(
                color: kdefaultshadow, blurRadius: 20, offset: Offset(0, 10))
          ]),
      width: size.width * 0.8,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          borderRadius: BorderRadius.circular(18),
          isExpanded: true,
          // isDense: true,
          icon: Icon(
            Icons.expand_circle_down_rounded,
            size: size.width * 0.1,
          ),
          iconEnabledColor: kprimarycolor,
          style: Manger().styleofText(kprimarycolor, false, 14, context, true),
          menuMaxHeight: size.height * 0.5,
          value: _selectedcity,
          onChanged: (newvalue) async {
            setState(() {
              _selectedcity = newvalue;
            });
          },
          items: _cities.map((city) {
            return DropdownMenuItem(
              child: Text(
                city,
                style: TextStyle(wordSpacing: 5),
              ),
              value: city,
            );
          }).toList(),
          hint: LocaleText("city", style: TextStyle(color: kprimarycolor)),
        ),
      ),
    );
  }

  

  Container sendbutton(Size size, BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: sendbuttondecoration,
      child: ElevatedButton(
        style: buttonStyle,
        onPressed: () async {
          if (checkinput()) {
            setState(() {
              errormessage = "sended succesfully";
            });
            try {
              var respone = apicaller.postrequest(add_sitelink, {
                'street': _StreetController.text,
                'buildadd': _buildingaddressController.text,
                'buildno': _buildingnumberController.text,
                'floor': _floornumberController.text
              });
            } catch (e) {
              print("send site error :$e");
            }
          } else {
            errormessage = Locales.string(context, "msgemptystate");
          }

          //   Get.showSnackbar();
          setState(() {
            enabled = false;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  backgroundColor: kprimarycolor,
                  content: Text(errormessage,
                      style: Manger().styleofText(
                          kbackground, false, 16, context, false))),
            );
          });
          //Timer(Duration(seconds: 1), () => setState(() => enabled = true));
          //pref.remove("key");
        },
        child: LocaleText(
          "add",
          style: Manger().styleofText(
              kbackground, false, size.width * 0.04, context, true),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Container back(Size size, BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: sendbuttondecoration,
        child: ElevatedButton(
            style: buttonStyle,
            onPressed: () => Get.back(),
            child: LocaleText(
              "back",
              style: Manger().styleofText(
                  kbackground, false, size.width * 0.04, context, true),
              textAlign: TextAlign.center,
            )));
  }
}
