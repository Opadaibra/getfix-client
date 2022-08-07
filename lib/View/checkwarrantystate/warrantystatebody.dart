//dashboard BODY

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:getfix/Controller/Apicaller.dart';
import 'package:getfix/Controller/linkapi.dart';
import 'package:getfix/Mywidgits/modifedappbar.dart';
import 'package:getfix/constants/constant.dart';

class warrantystatebody extends StatefulWidget {
  @override
  _warrantystatebodyState createState() => _warrantystatebodyState();
}

class _warrantystatebodyState extends State<warrantystatebody> {
  ScanResult? scanResult;
  final _flashOnController = TextEditingController(text: 'Flash on');
  final _flashOffController = TextEditingController(text: 'Flash off');
  final _cancelController = TextEditingController(text: 'Cancel');
  var _aspectTolerance = 1.00;
  var _selectedCamera = 1;

  var _autoEnableFlash = false;

  String messsagewarrnty = "";
  Apicaller apicaller = new Apicaller();
  // final qrkey = GlobalKey(debugLabel: 'QR');
  // QRView/Controller? controller;

  List checkmethod = [false, false, false];

  String qrcodr = "";
  var _selectedphonnumber;
  var phonnumber = ["0999999999", "0962934928"];

  @override
  Widget build(BuildContext context) {
    Size size = Manger().getsize(context);
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            modiefedappbar(
                size: size,
                widgiticon: Icon(
                  Icons.qr_code,
                  size: size.width * 0.12,
                  color: kbackground,
                ),
                localeText: LocaleText("checws", style: Headlinestyle)),
            //  padding2(size, 0.05),
            //  header(context, size),
            Manger().sizedBox(0, 0.05, context),
            entity(size, context),
            Manger().sizedBox(0, 0.01, context),
            sendbutton(size, context),
          ],
        ),
      ),
    );
  }

  Row header(BuildContext context, Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsetsDirectional.only(start: 10, top: 10),
          child: LocaleText("checws",
              textAlign: TextAlign.right,
              style: Manger().styleofText(
                kprimarycolor,
                false,
                size.width * 0.05,
                context,
                false,
              )),
        )
      ],
    );
  }

  Container entity(Size size, BuildContext context) {
    return Container(
        // width: size.width * 0.9,
        child: Column(
      children: [
        SizedBox(height: size.height * 0.01),
        emailbutton(size, context),
        SizedBox(height: size.height * 0.05),
        barcodebutton(size, context),
        SizedBox(height: size.height * 0.05),
        numberbutton(size, context),
        //divider(size),
        // ignore: unnecessary_null_comparison
        Text("$messsagewarrnty"),
      ],
    ));
  }
/*
  Container barcodeicon(BuildContext context) {
    return Container(
        child: checkmethod[2]
            ? ListTile(
                leading: Container(
                    //alignment: AlignmentDirectional.bottomStart,
                    //alignment: Alignment.center,
                    child: IconButton(
                        onPressed: () async {
                          await _scan();
                        },
                        icon: Icon(
                          Icons.camera_enhance_rounded,
                          color: Colors.grey,
                        ))),
                title: Container(
                  // alignment: Alignment.center,
                  // alignment: AlignmentDirectional.bottomCenter,
                  child: LocaleText(
                    'barcph',
                    style: Manger()
                        .styleofText(Colors.grey, false, 16, context, false),
                    // prefixIcon: Icon(Icons.camera_enhance_rounded)),
                  ),
                ))
            : null);
  }
*/
  // Widget buildQeView/(BuildContext context) =>
  //     QRView/(key: qrkey, onQRView/Created: onQRView/Created,
  //     overlay: QrScannerOverlayShape(),

  //     );
  // void onQRView/Created(QRView/Controller controller) {
  //   setState(() {
  //     this.controller = controller;
  //   });
  // }

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
        print(scanResult!.rawContent.toString());
        var respon = await apicaller.postrequest(
            checkwarranty, {"syr_num": scanResult!.rawContent.toString()});
        print(respon);
        if (respon['message'] == "True") {
          setState(() {
            messsagewarrnty = Locales.string(context, "iswarranty");
          });
        } else if (respon['message'] == "the machine doesn't exist") {
          setState(() {
            messsagewarrnty = Locales.string(context, "isnotwarranty");
          });
        } else {
          return;
        }
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
        leading: LocaleText(
          "barcodebut",
          style: TextStyle(color: kprimarycolor, fontWeight: FontWeight.bold),
          textAlign: TextAlign.start,
        ),
        trailing: IconButton(
            icon: Icon(
              Icons.qr_code,
              color: kprimarycolor,
            ),
            onPressed: _scan),
      ),
    );
  }

  Container numberbutton(Size size, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 42),
      height: size.height * 0.08,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kdefaultradius),
          boxShadow: [
            BoxShadow(
                blurRadius: 10, offset: Offset(0, 10), color: kdefaultshadow)
          ]),
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kdefaultradius),
              boxShadow: [
                BoxShadow(
                    color: kdefaultshadow,
                    blurRadius: 10,
                    offset: Offset(0, 10))
              ],
              color: kbackground),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              borderRadius: BorderRadius.circular(18),
              isExpanded: true,
              value: _selectedphonnumber,
              onChanged: (newvalue) async {
                setState(() {
                  _selectedphonnumber = newvalue;
                });
              },
              items: phonnumber.map((orderhead) {
                return DropdownMenuItem(
                  child: new Text(orderhead),
                  value: orderhead,
                );
              }).toList(),
              hint: LocaleText(
                "number",
                style: TextStyle(
                    color: kprimarycolor, fontWeight: FontWeight.bold),
              ),
            ),
          )),
    );
  }

  Container confirmationbutton(Size size, BuildContext context) {
    return Container(
        width: size.width * 0.3,
        height: size.height * 0.05,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(
                  color: kprimarycolor,
                  width: 1,
                ),
              ),
            ),
          ),
          onPressed: () {
            //send email method
          },
          child: Text(
            Locales.lang == "ar" ? "تأكيد" : "confirm",
            style:
                Manger().styleofText(kprimarycolor, false, 14, context, false),
          ),
        ));
  }

  Container canselbutton(Size size, BuildContext context) {
    return Container(
        width: size.width * 0.3,
        height: size.height * .05,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(
                  color: kprimarycolor,
                  width: 1,
                ),
              ),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            Locales.lang == "ar" ? "إغلاق" : "close",
            style:
                Manger().styleofText(kprimarycolor, false, 14, context, false),
          ),
        ));
  }

  Container emailbutton(Size size, BuildContext context) {
    return Container(
      //width: size.width * 0.8,
      margin: EdgeInsets.symmetric(horizontal: 42),
      height: size.height * .08,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kdefaultradius),
          boxShadow: [
            BoxShadow(
                blurRadius: 10, offset: Offset(0, 10), color: kdefaultshadow)
          ]),
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kdefaultradius),
              ),
            ),
          ),
          child: ListTile(
            leading: LocaleText(
              "email",
              style:
                  TextStyle(color: kprimarycolor, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            trailing: Icon(
              Icons.mail,
              color: kprimarycolor,
            ),
          ),
          onPressed: () {
            emaildialog(context, size);
            setState(() {
              checkmethod = [!checkmethod[0], false, false];
            });
          }),
    );
  }

  Future<dynamic> emaildialog(BuildContext context, Size size) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              scrollable: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              title: LocaleText("alert",
                  style: Manger()
                      .styleofText(kprimarycolor, false, 18, context, false),
                  textAlign: TextAlign.center),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // confirmationbutton(size, context),
                    SizedBox(width: size.width * 0.02),
                    canselbutton(size, context),
                  ],
                )
              ],
              content: Column(
                children: [
                  LocaleText(
                    "emailalert",
                    style: Manger()
                        .styleofText(kprimarycolor, false, 14, context, false),
                  ),
                  Text(
                    "opadaibra@gmail.com",
                    style: Manger()
                        .styleofText(ksecondrycolor, false, 14, context, false),
                  )
                ],
              ));
        });
  }

  Row sendbutton(Size size, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          width: size.width * 0.2,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(kprimarycolor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(
                    color: kprimarycolor,
                    width: .5,
                  ),
                ),
              ),
            ),
            child: LocaleText(
              "send",
              style: Manger().styleofText(
                  kbackground, false, size.width * 0.04, context, true),
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              setState(() {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: kprimarycolor,
                  duration: Duration(seconds: 2),
                  content:
                      // Text(
                      //     Locales.lang == "en"
                      //         ? "⚠ Sorry, missing barcode photo "
                      //         : "عذراً! لم يتم إرفاق صورة عن الباركود  ⚠",
                      //     textAlign: TextAlign.center,
                      //   )
                      // :
                      Text(Locales.lang == "en" ? "Done 👍" : "تم الإرسال 👍"),
                ));
              });
            },
          ),
        )
      ],
    );
  }

  Container divider(Size size) {
    return Container(
      width: size.width * 0.9,
      child: checkmethod[2]
          ? Divider(
              color: Colors.grey[600],
              height: 0,
              thickness: 0.7,
            )
          : null,
    );
  }

  Padding padding2(Size size, double decrease) =>
      Padding(padding: EdgeInsets.only(top: size.height * decrease));
}
