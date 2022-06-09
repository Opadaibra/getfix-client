//dashboard BODY

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/_http/interface/request_base.dart';
import 'package:getfix/Controller/Apicaller.dart';
import 'package:getfix/Controller/linkapi.dart';
import 'package:getfix/Mywidgits/modifedappbar.dart';
import 'package:getfix/View/addsite/Addsitesecond.dart';
import 'package:getfix/constants/constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

int sitecount = 0;

class Addsitebody extends StatefulWidget {
  @override
  _AddsitebodybodyState createState() => _AddsitebodybodyState();
}

var _selectedgovernorate;
var _selectedcity;
List governorates2 = [];

class _AddsitebodybodyState extends State<Addsitebody> {
  int current_id = 0;
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
  List<String> mysite = [];
  @override
  void initState() {
    // TODO: implement initState
    print(_selectedgovernorate);
    downloadcity();
    getcustomerid();
  }

  getcustomerid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getInt("customerid") != null)
      customer_id = preferences.getInt("customerid")!;
    print(customer_id);
  }

  final List<String> governorates = [];
  final List<int> governoratesid = [];
  // ignore: non_constant_identifier_names
  int city_id = 0;
  int Region_id = 0;
  List cities = [];
  List citiesid = [];

  @override
  Widget build(BuildContext context) {
    Size size = Manger().getsize(context);

    return Column(
      children: [
        modiefedappbar(
            size: size,
            widgiticon: Icon(
              Icons.location_on,
              size: size.width * 0.12,
              color: kbackground,
            ),
            localeText: LocaleText("addsite", style: Headlinestyle)),
        Verticaldefaultpadding,
        body(size, governorates, cities, context),
      ],
    );
  }

  Expanded body(Size size, List<dynamic> governorates, List<dynamic> cities,
      BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          Column(
            children: [
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
              ),
              Verticaldefaultpadding,
              //  next(size, context),

              //header(size, context),

              //Verticaldefaultpadding,
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
                  //   back(size, context),
                  sendbutton(size, context),
                ],
              )
            ],
          ),
        ],
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
            var respone = await apicaller.postrequest(add_sitelink, {
              'customer_id': "$customer_id",
              'city_id': "$city_id",
              'region_id': "$Region_id",
              'street': _StreetController.text
            });
            print("my respon $respone");
            setState(() {
              errormessage = "sended succesfully";
            });
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

  void downloadcity() async {
    var respne = await apicaller.getrequest(get_govling);
    final length = respne.length;
    for (int i = 0; i < length; i++) {
      print(respne[i]['name']);
      setState(() {
        governorates.add(respne[i]['name']);
        governoratesid.add(respne[i]['id']);
      });
    }
    print("${governorates[1]} + my id is ${governoratesid[1]} ");
  }

  void updatecity() {
    setState(() {
      cities = ["as", 'asd', 'adas'];
    });
  }

  bool checkinput() {
    if (_selectedgovernorate == null ||
        _selectedcity == null ||
        _StreetController.text.isEmpty) {
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
              for (int i = 0; i < governorates.length; i++) {
                if (governorates[i] == newvalue) {
                  city_id = governoratesid[i];
                }
              }
              print("ID : $city_id");
            });
            await getregionbycity(getbycity, city_id);
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

  getregionbycity(String url, int cityid) async {
    final queryParameters = {
      'city_id': "${cityid.toString()}",
    };

    final uri = Uri.https(
        "al-hafez.herokuapp.com", '/api/region/getByCity', queryParameters);
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    try {
      var respone = await http.get(uri, headers: headers);

      if (respone.statusCode == 200) {
        var responsebody = jsonDecode(respone.body);
        final length = responsebody.length;
        setState(() {
          cities.clear();
          citiesid.clear();
        });
        for (int i = 0; i < length; i++) {
          print(responsebody[i]['name']);
          setState(() {
            cities.add(responsebody[i]['name']);
            citiesid.add(responsebody[i]['id']);
          });
        }
        return responsebody;
      } else {
        print("Error ${respone.statusCode}");
      }
    } catch (e) {
      print("Errore api sending unsuccessfully$e");
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
              for (int i = 0; i < cities.length; i++) {
                if (cities[i] == newvalue) {
                  Region_id = citiesid[i];
                }
              }
              print("RegionID : $Region_id");
            });
            await getregionbycity(getbycity, city_id);
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

  Container next(Size size, BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: sendbuttondecoration,
      margin: buttonmargen,
      child: ElevatedButton(
        style: buttonStyle,
        onPressed: () => Get.to(Addsiteseconde()),
        child: LocaleText(
          "next",
          style: Manger().styleofText(
              kbackground, false, size.width * 0.04, context, true),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
