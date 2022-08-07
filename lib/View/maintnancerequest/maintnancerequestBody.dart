//Sign BODY

import 'dart:async';

import 'dart:io';
import 'dart:convert';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:getfix/Controller/Apicaller.dart';
import 'package:getfix/Controller/linkapi.dart';
import 'package:getfix/View/addsite/Addsitebody.dart';
import 'package:getfix/constants/constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

//import 'package:fluttertoast/fluttertoast.dart';

int sitecount = 0;

class MaintnancerequestBody extends StatefulWidget {
  @override
  _maintnancerequestState createState() => _maintnancerequestState();
}

class _maintnancerequestState extends State<MaintnancerequestBody> {
  ScanResult? scanResult;
  final _flashOnController = TextEditingController(text: 'Flash on');
  final _flashOffController = TextEditingController(text: 'Flash off');
  final _cancelController = TextEditingController(text: 'Cancel');
  var _aspectTolerance = 1.00;
  var _selectedCamera = 1;
  var _autoEnableFlash = false;
  bool check1 = false;
  List<String> mysite = [];
  List<String> machinlist = [];
  List<int> templist = [];
//  File? myfile;

  final recorder = FlutterSoundRecorder();
  String statusmsg = "";
  // ignore: deprecated_member_use
  var _selectedsite;
  var arr = [false, false, false];
  final TextEditingController machinsize = new TextEditingController();
  final TextEditingController maintenanceday = new TextEditingController();
  final TextEditingController comenucationnum = new TextEditingController();
  final TextEditingController explainstate = new TextEditingController();
  final TextEditingController name = new TextEditingController();
  final TextEditingController note = new TextEditingController();
  Apicaller apicaller = new Apicaller();

  @override
  // ignore: must_call_super
  void initState() {
    initrecorder();
    // SetuserSitelist();
    Future.delayed(Duration(seconds: 2), () {
      SetuserSitelist();
    });
    getcustomerid();
  }

  Future initrecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Microphone Permission not granted';
    }
    await recorder.openRecorder();
  }

  void dispos() {
    recorder.closeRecorder();
    super.dispose();
  }

  getcustomerid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getInt("customerid") != null)
      customer_id = preferences.getInt("customerid")!;
    print(customer_id);
  }

  // ignore: non_constant_identifier_names
  SetuserSitelist() async {
    final queryParameters = {
      'customer_id': "$customer_id",
    };
    final uri = Uri.https("al-hafez.herokuapp.com",
        '/api/address/get_all_addresses', queryParameters);
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    try {
      var respone = await http.get(uri, headers: headers);

      if (respone.statusCode == 200) {
        var responsebody = jsonDecode(respone.body);
        final length = responsebody.length;
        print(responsebody);
        setState(() {
          mysite.clear();
        });
        for (int i = 0; i < length; i++) {
          // print(responsebody[i]['name']);

          setState(() {
            mysite.add(
                "${responsebody[i]['region']},${responsebody[i]['city']},${responsebody[i]['street']}");
            templist.add(i);
          });
        }
        return responsebody;
      } else {
        print("Errorss ${respone.statusCode}");
      }
    } catch (e) {
      print("Errore api sending unsuccessfully$e");
    }
  }

  // final TextEditingController  maintenanceday= new TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = Manger().getsize(context);
    return Column(children: [
      sitedrobdowbutton(size, context),
      defaultpadd,
      //machin(context, size),
      defaultpadd,
      Text(
        "$statusmsg",
        style: TextStyle(color: kerror),
      ),
      Expanded(child: body(size))
    ]);
  }

  Container sitedrobdowbutton(Size size, BuildContext context) {
    return Container(
      height: size.height * 0.1,
      child: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(0, -2),
            child: Container(
              width: size.width,
              height: size.height * 0.1 - 27,
              decoration: BoxDecoration(
                  color: kprimarycolor,
                  borderRadius: BorderRadiusDirectional.only(
                      bottomEnd: Radius.circular(kdefaultradius),
                      bottomStart: Radius.circular(kdefaultradius))),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 54,
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              decoration: BoxDecoration(
                  color: kbackground,
                  borderRadius: BorderRadius.circular(kdefaultradius),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 20,
                        color: Colors.black12.withOpacity(0.23))
                  ]),
              child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      isExpanded: true,
                      //  autofocus: false,
                      style: Manger().styleofText(
                          ksecondrycolor, false, 14, context, true),
                      value: _selectedsite,
                      onChanged: (newvalue) async {
                        setState(() {
                          _selectedsite = newvalue;
                          seperatlistitems(_selectedsite);
                        });
                      },
                      items: mysite.map((site) {
                        return DropdownMenuItem(
                          child: new Text(
                            site,
                            style: TextStyle(wordSpacing: 5),
                          ),
                          value: site,
                        );
                      }).toList(),
                      hint: LocaleText(
                        "site",
                        style: Manger().styleofText(
                            kprimarycolor, false, 14, context, true),
                      ),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  ListView body(Size size) {
    return ListView(
      children: [fillorders(1, size)],
    );
  }

  Future<void> _scan() async {
    try {
      final result = await BarcodeScanner.scan(
        options: ScanOptions(
          strings: {
            'cancel': _cancelController.text,
            'flash_on': _flashOnController.text,
            'flash_off': _flashOffController.text,
          },
          useCamera: -1,
          autoEnableFlash: _autoEnableFlash,
          android: AndroidOptions(
            aspectTolerance: _aspectTolerance,
            useAutoFocus: true,
          ),
        ),
      );

      setState(() => scanResult = result);
      if (scanResult != null) {
        print("qr is :${scanResult!.rawContent}");
      } else {
        print("123t");
      }
    } on PlatformException catch (e) {
      setState(() {
        scanResult = ScanResult(
          type: ResultType.Error,
          format: BarcodeFormat.qr,
          // format: BarcodeFormat.unknown,
          rawContent: e.code == BarcodeScanner.cameraAccessDenied
              ? 'The user did not grant the camera permission!'
              : 'Unknown error: $e',
        );
      });
    }
  }

  Container barcodebutton(Size size, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 42),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      height: size.height * .08,
      // width: size.width * .8,
      decoration: BoxDecoration(
          color: kbackground,
          borderRadius: BorderRadius.circular(kdefaultradius),
          boxShadow: [
            BoxShadow(
                blurRadius: 10, offset: Offset(0, 20), color: kdefaultshadow)
          ]),
      child: ListTile(
        leading: scanResult != null
            ? LocaleText(
                "barcodebut",
                style: TextStyle(
                    color: kprimarycolor, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              )
            : Text(""),
        trailing: IconButton(
            icon: Icon(
              Icons.qr_code,
              color: kprimarycolor,
            ),
            onPressed: _scan),
      ),
    );
  }

  int whatisstate() {
    return 2;
  }

  List<Step> getstep() => [
        Step(
          title: Text("requestsend"),
          content: Container(),
        ),
        Step(title: Text("processing"), content: Container()),
        Step(title: Text("Done"), content: Container()),
      ];

  Container fillorders(int type, Size size) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: SingleChildScrollView(
          child: Container(
        decoration: kboxdecoration,
        child: Column(children: [
          // sizeofmachine(size),
          // maintenancedate(size),
          changename(size),
          phonenumber(size),
          explainissue(size),
          barcodephoto(size),
          //  voicerecorde(size, context),
          Verticaldefaultpadding,
          sendbuton(size, context),
        ]),
      )),
    );
  }

  bool recording = false;
  Container voicerecorde(Size size, BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(10),
      child: Column(
        children: [
          StreamBuilder<RecordingDisposition>(
              stream: recorder.onProgress,
              builder: (context, snapshot) {
                final duration =
                    snapshot.hasData ? snapshot.data!.duration : Duration.zero;

                return Text("${duration.inSeconds} s");
              }),
          Row(
            children: [
              LocaleText("record", style: khintstyle),
              ElevatedButton(
                  onPressed: () async {
                    if (recorder.isRecording) {
                      await stop();
                      setState(() {
                        recording = false;
                      });
                    } else {
                      record();
                      setState(() {
                        recording = true;
                      });
                    }
                  },
                  child: Icon(
                    recording ? Icons.stop : Icons.mic,
                    size: size.width * 0.07,
                    color: kerror,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Future record() async {
    await recorder.startRecorder(toFile: 'audio');
  }

  Future stop() async {
    await recorder.stopRecorder();
  }

  Container notes(Size size) {
    return Container(
      margin: defaultmargin,
      child: TextField(
        controller: note,
        minLines: 1,
        maxLines: 5,
        decoration: InputDecoration(
            hintText: Locales.lang == "en" ? "Notes " : "ملاحظات",
            hintStyle: khintstyle),
        textAlign: TextAlign.start,
        keyboardType: TextInputType.name,
      ),
    );
  }

  Column dammagevedio(Size size) {
    return Column(children: [
      ListTile(
        //    alignment: Alignment.center,
        trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.video_camera_back_rounded,
              color: Colors.grey,
            )),

        title:
            //width: size.width * 0.75,
            LocaleText(
          'vedio',
          style: khintstyle,
          // prefixIcon: Icon(Icons.camera_enhance_rounded)),
        ),
      ),
      Container(
        width: size.width * .9,
        child: Divider(
          height: 0,
          thickness: .5,
          color: Colors.grey[800],
        ),
      ),
    ]);
  }

  Column barcodephoto(Size size) {
    return Column(
      children: [
        ListTile(
          //    alignment: Alignment.center,
          trailing: IconButton(
              onPressed: _scan,
              icon: Icon(
                Icons.qr_code,
                color: Colors.grey,
              )),

          title:
              //width: size.width * 0.75,
              LocaleText('barcph', style: khintstyle
                  // prefixIcon: Icon(Icons.camera_enhance_rounded)),
                  ),
        ),
        Container(
          width: size.width * .9,
          child: Divider(
            height: 0,
            thickness: .5,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }

  Container changename(Size size) {
    return Container(
      margin: defaultmargin,
      child: TextField(
        controller: name,
        minLines: 1,
        maxLines: 5,
        decoration: InputDecoration(
            hintText: Locales.lang == "en" ? "name" : "الاسم",
            hintStyle: khintstyle),
        textAlign: TextAlign.start,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
      ),
    );
  }

  Container explainissue(Size size) {
    return Container(
      margin: defaultmargin,
      child: TextField(
        controller: explainstate,
        minLines: 1,
        maxLines: 5,
        decoration: InputDecoration(
            hintText: Locales.lang == "en" ? "Explain Issue " : "شرح الحالة",
            hintStyle: khintstyle),
        textAlign: TextAlign.start,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
      ),
    );
  }

  Container phonenumber(Size size) {
    return Container(
      margin: defaultmargin,
      child: TextField(
        controller: comenucationnum,
        decoration: InputDecoration(
            hintText: Locales.lang == "en" ? "Phone number " : "رقم التواصل",
            hintStyle: khintstyle),
        textAlign: TextAlign.start,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
      ),
    );
  }

  Container maintenancedate(Size size) {
    return Container(
      margin: defaultmargin,
      child: TextField(
        controller: maintenanceday,
        decoration: InputDecoration(
            hintText: Locales.lang == "en"
                ? "Favorite maintenance day"
                : "يوم الصيانة الذي تفضله",
            hintStyle: khintstyle),
        textAlign: TextAlign.start,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
      ),
    );
  }

  bool iswarrantyed = false;
  iswarranty() async {
    //iswarrantyed = true;
    try {
      if (scanResult != null) {
        var respon = await apicaller.postrequest(
            checkwarranty, {"syr_num": scanResult!.rawContent.toString()});
        print(respon);
        if (respon['message'] == "True") {
          setState(() {
            iswarrantyed = true;
          });
        } else if (respon['message'] == "False") {
          setState(() {
            iswarrantyed = false;
          });
        }
      } else {
        setState(() {
          statusmsg = "Scan Qr first";
        });
      }
    } on Exception catch (e) {
      print("Error Checked warranty:$e");
    }
  }

  Container sendbuton(Size size, BuildContext context) {
    return Container(
      decoration: sendbuttondecoration,
      child: ElevatedButton(
          style: buttonStyle,
          child: buttontext,
          onPressed: () {
            iswarranty();
            Get.defaultDialog(
              content: Column(
                children: [
                  LocaleText(
                    "sendmain",
                    textAlign: TextAlign.center,
                  ),
                  Column(
                    children: [
                      LocaleText(
                        scanResult == null ? "qrnotenter" : "not",
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                      Container(
                        child: scanResult != null
                            ? Text(iswarrantyed
                                ? Locales.string(context, "iswarranty")
                                : Locales.string(context, "isnotwarranty"))
                            : null,
                      ),
                    ],
                  )
                ],
              ),
              cancel: InkWell(
                onTap: () => Get.back(),
                child: LocaleText(
                  "cancel",
                  style: dialogbuttonstyle,
                ),
              ),
              confirm: InkWell(
                onTap: () {
                  print('asdasdasfa');
                  sendrequest();
                },
                child: LocaleText(
                  "confirm",
                  style: dialogbuttonstyle,
                ),
              ),
            );
          }),
    );
  }

  bool checkfield() {
    if (maintenanceday.text.isEmpty ||
        explainstate.text.isEmpty ||
        scanResult == null ||
        Street == "" ||
        cityid == 0 ||
        regionid == 0 ||
        name.text.isEmpty) {
      return false;
    }

    return true;
  }

  String city = "";

  void seperatlistitems(String currentsite) {
    // currentsite.split(" ");
    List temp = currentsite.split(",");
    print(temp[0]);
    getregionid(temp[0]);
    getcityid(temp[1]);
    Street = temp[2];
  }

  getregionid(String region) async {
    var respon = await apicaller.postrequest(getregionbystring, {
      "name": region,
    });
    if (respon["message"] != "Not Found") {
      regionid = respon["id"];
    }
    print(respon);
  }

  int cityid = 0;
  int regionid = 0;
  String Street = "";

  getcityid(String city) async {
    var respon = await apicaller.postrequest(getcitybystring, {
      "name": city,
    });
    print(respon);
    if (respon["message"] != "Not Found") {
      cityid = respon["id"];
    }
  }

  void sendrequest() async {
    print("addddd");
    try {
      var response = await apicaller.postrequest(sendmainreq, {
        "name": name.text,
        "problem": explainstate.text,
        "number1": comenucationnum.text,
        "street": Street,
        "city_id": "$cityid",
        "region_id": "$regionid",
        "syr_num": scanResult!.rawContent.toString(),
      });
      print(response);
    } on Exception catch (e) {
      print(e);
    }
  }

  String getmachintype() {
    if (arr[0]) {
      return "refregator";
    } else if (arr[1]) {
      return "washer";
    } else if (arr[2]) {
      return "air condition";
    } else {
      return "no";
    }
  }
}
