//Sign BODY

import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:getfix/Controller/Apicaller.dart';
import 'package:getfix/Mywidgits/modifedappbar.dart';
import 'package:getfix/constants/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:fluttertoast/fluttertoast.dart';

class Showproductsbody extends StatefulWidget {
  @override
  _ShowproductsbodyState createState() => _ShowproductsbodyState();
}

class _ShowproductsbodyState extends State<Showproductsbody> {
  List userdata = [];
  String phonenumber = '';
  getphonenumber() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      phonenumber = pref.getString("phonenumber")!;
      print("asdas $phonenumber");
    } catch (e) {
      print("error get phonenumber $e");
    }
  }

  Future viewprod() async {
    print("pasdsad $phonenumber");
    final queryParameters = {
      'number': phonenumber,
    };
    final uri = Uri.https('al-hafez.herokuapp.com',
        '/api/customer/get_all_products', queryParameters);
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var responsebody = jsonDecode(response.body);
      for (int i = 0; i < responsebody.length; i++) {
        setState(() {
          userdata.add(responsebody[i]);
        });
      }
      print(userdata);
    } else {
      print("Error ${response.body}");
    }
    // userdata = respone["id"];
  }

  // ignore: deprecated_member_use
  Apicaller apicaller = new Apicaller();
  int machinlength = 0;
  var arr = [false, false, false];
  var order = [
    Locales.lang == "en" ? "Old" : "الأقدم",
    Locales.lang == "en" ? "New" : "الأحدث"
  ];
  @override
  void initState() {
    getphonenumber();
    Future.delayed(Duration(seconds: 2), () {
      viewprod();
    });

    print(customer_id);
  }

  var _selectedorder;
  @override
  Widget build(BuildContext context) {
    Size size = Manger().getsize(context);

    return Column(
      children: [
        modiefedappbar(
            size: size,
            widgiticon: Icon(
              Icons.home,
              size: size.width * 0.12,
              color: kbackground,
            ),
            localeText: LocaleText("showprod", style: Headlinestyle)),
        Verticaldefaultpadding,
        Text(
          userdata.isEmpty ? "There are no request" : "",
          style: TextStyle(
            fontSize: 26,
          ),
        ),
        Expanded(child: body(size)),
      ],
    );
  }

  ListView body(Size size) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(5, 0),
            )
          ], borderRadius: BorderRadius.circular(20), color: kbackground),
          child: GestureDetector(
            onTap: () {
              Get.defaultDialog(
                title: "details",
                content: Column(
                  children: [
                    ListTile(
                      leading: Text(
                        " اسم الجهاز",
                      ),
                      trailing: Text("${userdata[index]["name"]}"),
                    ),
                    ListTile(
                      leading: Text(
                        "تاريخ بداية الكفالة ",
                      ),
                      trailing:
                          Text("${userdata[index]["start_warranty_date"]}"),
                    ),
                    ListTile(
                      leading: Text("تاريخ نهاية الكفالة"),
                      trailing: Text("${userdata[index]["end_warranty_date"]}"),
                    ),
                    ListTile(
                      leading: Text(
                        " رقم الجهاز ",
                      ),
                      trailing: Text("${userdata[index]["syrial_number"]}"),
                    ),
                    ListTile(
                      leading: Text(
                        " حالة الجهاز ",
                      ),
                      trailing: Text("${userdata[index]["status"]}"),
                    ),
                  ],
                ),
              );
            },
            child: Column(
              children: [
                if (index > 0)
                  ListTile(
                    leading: Text(
                      " اسم الجهاز",
                    ),
                    trailing: Text("${userdata[index]["name"]}"),
                  ),
                if (index > 0)
                  ListTile(
                    leading: Text("تاريخ نهاية الكفالة"),
                    trailing: Text("${userdata[index]["end_warranty_date"]}"),
                  ),
              ],
            ),
          ),
        );
      },
      itemCount: userdata.isEmpty ? 0 : userdata.length,
    );
  }
}
