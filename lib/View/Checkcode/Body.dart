//Sign BODY
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:getfix/Controller/Apicaller.dart';
import 'package:getfix/constants/constant.dart';
import 'package:getfix/View/Clientdashboard/Dashboard.dart';

class Body extends StatelessWidget {
  Apicaller databaseHelper = new Apicaller();

  final TextEditingController pincontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = Manger().getsize(context);
    Padding padding2(Size size, double decreasrate) =>
        Padding(padding: EdgeInsets.only(top: size.height * decreasrate));
    return Container(
        //alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
            vertical: size.width * 0.05, horizontal: size.height * 0.002),
        child: SingleChildScrollView(
          child: Column(
            children: [
              padding2(size, 0.01),
              topImage(size),
              padding2(size, 0.1),
              middilentity(size, context),
              padding2(size, 0.08),
              downbutton(size, context)
            ],
          ),
        ));
  }

  Container middilentity(Size size, BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
              child: Image.asset(
            "Images/codebackground.png",
            width: double.infinity,
            scale: size.width * 0.001,
          )),
          Column(
            children: [
              Padding(padding: EdgeInsets.all(size.width * 0.04)),
              toptext(context),
              Padding(padding: EdgeInsets.all(size.width * 0.02)),
              codeblanks(size, context),
              Padding(padding: EdgeInsets.all(size.width * 0.05)),
              resend(context),
            ],
          )
        ],
      ),
    );
  }

  Container codeblanks(Size size, BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: size.width * 0.70,
        height: size.height * 0.06,
        child: PinInputTextFormField(
          pinLength: 4,
          controller: pincontroller,
          decoration: BoxLooseDecoration(
            strokeWidth: 3,
            strokeColorBuilder: PinListenColorBuilder(
              kprimarycolor,
              kbackground,
            ),
            textStyle: Manger().styleofText(
                kprimarycolor, false, size.width * 0.08, context, true),
          ),
          // obscureStyle:
          //     ObscureStyle(obscureText: '*', isTextObscure: true),
          // textStyle: TextStyle(color: Colors.white)),
          onSubmit: (String pin) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      'pin',
                      textAlign: TextAlign.center,
                      style: Manger().styleofText(ksecondrycolor, false,
                          size.width * 0.05, context, true),
                    ),
                    content: Text('your pin is $pin'),
                  );
                });
          },
        )
        /*TextField(
                //  controller: _passwordController,
                textAlign: TextAlign.center,

                decoration: InputDecoration(
                  focusColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: new BorderSide(
                      width: 2.0,
                      color: Colors.white,
                      //style: BorderStyle.solid
                    ),
                    borderRadius: new BorderRadius.all(Radius.circular(120)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: new BorderSide(
                      width: 2.0,
                      color: Colors.black,
                      //style: BorderStyle.solid
                    ),
                    borderRadius: new BorderRadius.all(Radius.circular(120)),
                  ),

                  hintText: "رقم التعريف",
                  hintStyle: hidline4textStyle,

                  // icon: Icon(Icons.person),
                ),
                cursorColor: Colors.white,

                style: buttontext,

                keyboardType: TextInputType.visiblePassword,
              ),*/
        );
  }

  Container topImage(Size size) {
    return Container(
      child: Image.asset("Images/GetFix.png",
          width: size.width,
          alignment: Alignment.center,
          filterQuality: FilterQuality.high),
    );
  }

  Container toptext(BuildContext context) {
    return Container(
      child: LocaleText(
        "enterdigit",
        style: Manger().styleofText(kbackground, false, 14, context, false),
        textAlign: TextAlign.center,
      ),
    );
  }

  Container resend(BuildContext context) {
    return Container(
      child: TextButton(
        child: LocaleText(
          "resend",
          style: TextStyle(
              decoration: TextDecoration.underline,
              color: kprimarycolor,
              fontSize: 18),
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: LocaleText(
                    "resend",
                    style: Manger()
                        .styleofText(ksecondrycolor, false, 18, context, false),
                    textAlign: TextAlign.center,
                  ),
                  content: LocaleText(
                    "codesendagain",
                    style: Manger()
                        .styleofText(kprimarycolor, false, 16, context, false),
                    textAlign: TextAlign.center,
                  ),
                );
              });
        },
      ),
    );
  }

  Container downbutton(Size size, BuildContext context) {
    return Container(
        child: MaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (context) => new Dashboard(),
          ),
        );
      },
      color: Color(0xFF37506c),
      textColor: Colors.white,
      child: Icon(
        Icons.arrow_back_rounded,
        size: size.width * 0.1,
      ),
      padding: EdgeInsets.all(16),
      shape: CircleBorder(),
    ));
  }
}
