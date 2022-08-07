//Sign BODY

import 'dart:convert';
import 'dart:io';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:getfix/Controller/linkapi.dart';
import 'package:getfix/View/addsite/Addsitebodysecond.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:getfix/Controller/Apicaller.dart';
import 'package:getfix/Mywidgits/modifedappbar.dart';
import 'package:getfix/constants/constant.dart';
//import 'package:fluttertoast/fluttertoast.dart';

class Dashboardbody extends StatefulWidget {
  @override
  _DashboardbodyState createState() => _DashboardbodyState();
}

class _DashboardbodyState extends State<Dashboardbody> {
  List userdata = [];
  double rate = 0;
  final TextEditingController note = new TextEditingController();
  Future fetchmachin() async {
    print(customer_id);

    final queryParameters = {
      'id': "1",
    };
    final uri = Uri.https('al-hafez.herokuapp.com',
        '/api/customer/get_my_missions', queryParameters);
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
    fetchmachin();

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
            localeText: LocaleText("showtasks", style: Headlinestyle)),
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

  bool enablerate = false;
  String statmessage = "";

  getstate(int index) {
    print("asdsadsa ${userdata[index]["status_id"]}");
    int x = userdata[index]["status_id"];

    switch (x) {
      case 1:
        setState(() {
          statmessage = "مرسل";
          enablerate = false;
        });
        break;
      case 2:
        setState(() {
          statmessage = "جار المعالجة";
          enablerate = false;
        });
        break;
      case 4:
        setState(() {
          statmessage = "منتهي";
          enablerate = true;
        });
        break;
      case 5:
        setState(() {
          statmessage = "مؤجل  ";
          enablerate = false;
        });
        break;
      default:
    }
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
              print("asdsadsa ${userdata[index]["status_id"]}");

              getstate(index);
              Get.defaultDialog(
                title: "details",
                content: SingleChildScrollView(
                  child: Column(children: [
                    ListTile(
                      leading: Text(
                        " اسم المستخدم",
                      ),
                      trailing: Text("${userdata[index]["name_of_customer"]}"),
                    ),
                    ListTile(
                      leading: Text(
                        "الكفالة ",
                      ),
                      trailing: Text("${userdata[index]["warranty"]}"),
                    ),
                    // ListTile(
                    //   leading: Text(
                    //     " يوم الصيانة المفضل",
                    //   ),
                    //   trailing: Text("${userdata[index]["day_favorite"]}"),
                    // ),
                    ListTile(
                      leading: Text(
                        "رقم المهمة",
                      ),
                      trailing: Text("${userdata[index]["id"]}"),
                    ),
                    ListTile(
                      leading: Text(
                        "رقم الموبايل",
                      ),
                      trailing: Text("${userdata[index]["phone_number1"]}"),
                    ),
                    ListTile(
                      leading: Text(
                        "نوع الآلة",
                      ),
                      trailing: Text("${userdata[index]["machine_type"]}"),
                    ),
                    ListTile(
                      leading: Text(
                        "تاريخ الانشاء",
                      ),
                      trailing: Text("${userdata[index]["created_at"]}"),
                    ),
                    ListTile(
                      leading: Text(
                        "الشارع",
                      ),
                      trailing: Text("${userdata[index]["street"]}"),
                    ),
                    ListTile(
                      leading: Text(
                        "حالة الطلب",
                      ),
                      trailing: Text(statmessage),
                    ),
                    if (enablerate) Text("تقييم فريق الصيانة"),
                    Container(
                      child: TextField(
                        controller: note,
                        decoration: InputDecoration(hintText: "ادخل التقييم"),
                      ),
                    ),
                    Container(
                      child: enablerate
                          ? RatingBar.builder(
                              minRating: 0,
                              allowHalfRating: false,
                              maxRating: 5,
                              glow: true,
                              glowColor: kprimarycolor,
                              updateOnDrag: true,
                              unratedColor: kprimarycolor,
                              itemBuilder: (context, _) =>
                                  Icon(Icons.star_rounded, color: Colors.amber),
                              onRatingUpdate: (rating) {
                                setState(() {
                                  rate = rating;
                                });
                                print(rate);
                              })
                          : null,
                    ),
                    if (enablerate)
                      ElevatedButton(
                        onPressed: sendrate,
                        child: Text("إرسال التقييم"),
                        style: buttonStyle,
                      ),
                  ]),
                ),
              );
            },
            child: Column(
              children: [
                ListTile(
                  leading: Text(
                    "رقم المهمة",
                  ),
                  trailing: Text("${userdata[index]["id"]}"),
                ),
                ListTile(
                    leading: Text(
                      "رقم الموبايل",
                    ),
                    trailing: Text("${userdata[index]["phone_number1"]}"),
                    dense: true),
                ListTile(
                    leading: Text(
                      "نوع الآلة ",
                    ),
                    trailing: Text("${userdata[index]["machine_type"]}"),
                    dense: true),
                ListTile(
                    leading: Text(
                      "تاريخ الانشاء",
                    ),
                    trailing: Text("${userdata[index]["created_at"]}"),
                    dense: true),
              ],
            ),
          ),
        );
      },
      itemCount: userdata.isEmpty ? 0 : userdata.length,
    );
  }

  sendrate() async {
    var respone = await apicaller.postrequest(ratelinke, {
      "rate": rate.toInt(),
      "note": note.text,
      "customer_id": "$customer_id",
      "maintenance_workshop": "13"
    });
    print(respone);
    // try {
    //   if (respone['message'] == "succes") {
    //     setState(() {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(
    //             backgroundColor: kprimarycolor,
    //             content: Text("تم إرسال التقييم",
    //                 style: Manger()
    //                     .styleofText(kbackground, false, 16, context, false))),
    //       );
    //     });
    //   }
    // } on Exception catch (e) {
    //   // TODO
    // }
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //       backgroundColor: kprimarycolor,
    //       content: Text("لم يتم إرسال التقييم",
    //           style: Manger()
    //               .styleofText(kbackground, false, 16, context, false))),
    // );
  }

  Container vewingorders(BuildContext context) {
    return Container(
        alignment: AlignmentDirectional.topStart,
        padding: EdgeInsetsDirectional.only(start: 10, top: 10),
        child: anybuttonpressed()
            ? ListTile(
                title: LocaleText(
                  "orasd",
                  style: Manger()
                      .styleofText(kprimarycolor, false, 18, context, false),
                  textAlign: TextAlign.start,
                ),
                trailing: DropdownButton(
                  value: _selectedorder,
                  onChanged: (newvalue) async {
                    setState(() {
                      _selectedorder = newvalue;
                    });
                  },
                  items: order.map((orderhead) {
                    return DropdownMenuItem(
                      child: new Text(orderhead),
                      value: orderhead,
                    );
                  }).toList(),
                  hint: LocaleText("orasd"),
                ),
              )
            : null);
  }

  Container machin(BuildContext context, Size size) {
    return Container(
      height: size.height * 0.2,
      margin: defaultmargin,
      decoration: kboxdecoration,
      child: Column(
        children: [
          Padding(padding: EdgeInsets.all(5)),
          LocaleText(
            "pickview",
            style: TextStyle(
                color: kprimarycolor,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Image.asset(
                  "Images/freazer.png",
                  color: arr[0] == true ? kprimarycolor : ksecondrycolor,
                ),
                onPressed: () {
                  setState(() {
                    arr = [!arr[0], false, false];
                  });
                },

                iconSize: size.width * 0.2,
                splashRadius: size.width * 0.1,
                highlightColor: kprimarycolor,

                //   splashColor: kprimarycolor,
              ),
              IconButton(
                icon: Image.asset(
                  "Images/wachmachine.png",
                  color: arr[1] == true ? kprimarycolor : ksecondrycolor,
                ),
                onPressed: () {
                  setState(() {
                    arr = [false, !arr[1], false];
                    //  wachmachin = !wachmachin;
                  });
                },
                iconSize: size.width * 0.2,
                splashRadius: size.width * 0.1,
                highlightColor: kprimarycolor,
              ),
              IconButton(
                icon: Image.asset(
                  "Images/aircooler.png",
                  color: arr[2] == true ? kprimarycolor : ksecondrycolor,
                ),
                onPressed: () {
                  setState(() {
                    // aircooler = !aircooler;
                    arr = [false, false, !arr[2]];
                  });
                },
                iconSize: size.width * 0.2,
                splashRadius: size.width * 0.1,
                highlightColor: kprimarycolor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  SingleChildScrollView orders(int type, Size size) {
    List<int> i = [1, 2, 3];
    return SingleChildScrollView(
        child: Column(children: [
      if (type == 1)
        for (int j = 0; j < i.length; j++)
          Viewfreezcontant(
              size, "2/" + "${j + 8}" + "/2022", 15 + j * 3, j + 1),
      Padding(padding: EdgeInsets.all(10))
    ]));
  }

  Column Viewfreezcontant(
      Size size, String dateTime, int freezasize, int myid) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.all(10)),
        GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    title: LocaleText(
                      "detailes",
                      style: Manger().styleofText(
                          ksecondrycolor, false, 18, context, false),
                      textAlign: TextAlign.center,
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: LocaleText(
                            "reqno",
                            style: Manger().styleofText(
                                kprimarycolor, false, 16, context, false),
                            textAlign: TextAlign.start,
                          ),
                          trailing: Text("$myid"),
                        ),
                        ListTile(
                          title: LocaleText(
                            "reqdate",
                            style: Manger().styleofText(
                                kprimarycolor, false, 16, context, false),
                            textAlign: TextAlign.start,
                          ),
                          trailing: Text(dateTime),
                        ),
                        ListTile(
                          title: LocaleText(
                            "freezsize",
                            style: Manger().styleofText(
                                kprimarycolor, false, 16, context, false),
                            textAlign: TextAlign.start,
                          ),
                          trailing: Text("$freezasize"),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10)),
                            ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(kprimarycolor),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0))),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    backgroundColor: kprimarycolor,
                                    duration: Duration(seconds: 2),
                                    content: Text(Locales.lang == "en"
                                        ? "complaint has been sent successfully 👍"
                                        : "تم إرسال الشكوى بنجاح 👍"),
                                  ));
                                },
                                child: Text(
                                  "Make a complaint",
                                  style: TextStyle(color: kbackground),
                                )),
                          ],
                        )
                      ],
                    ),
                  );
                });
          },
          child: Container(
            width: size.width * .85,
            decoration: kboxdecoration,
            child: Column(
              children: [
                Container(
                  //margin: EdgeInsets.all(10),
                  child: ListTile(
                      title: LocaleText(
                        "reqdate",
                        textAlign: TextAlign.start,
                      ),
                      trailing: Text(
                        dateTime,
                        textAlign: TextAlign.end,
                      )),
                ),
                Container(
                  child: ListTile(
                      title: LocaleText(
                        "freezsize",
                        textAlign: TextAlign.start,
                      ),
                      trailing: Text(
                        "$freezasize",
                        textAlign: TextAlign.end,
                      )),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  bool anybuttonpressed() {
    for (var i = 0; i < arr.length; i++) {
      if (arr[i] == true) return true;
    }
    return false;
  }
}
