//dashboard BODY

import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:getfix/Mywidgits/modifedappbar.dart';
import 'package:getfix/constants/constant.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Ratemaintenancebody extends StatefulWidget {
  @override
  _RatemaintenancebodyState createState() => _RatemaintenancebodyState();
}

class _RatemaintenancebodyState extends State<Ratemaintenancebody> {
  var preesedstar = [false, false, false, false, false];
  double _rating = 0.0;
  String ratetext = "";
  TextEditingController _teamnumbercontroller = new TextEditingController();
  TextEditingController _notescontroller = new TextEditingController();
  Color gradiant = Color(0xFF053F5E);
  @override
  Widget build(BuildContext context) {
    Size size = Manger().getsize(context);
    return Column(
      children: [
        modiefedappbar(
            size: size,
            widgiticon: Icon(
              Icons.rate_review,
              size: size.width * 0.12,
              color: kbackground,
            ),
            localeText: LocaleText("rate", style: Headlinestyle)),
        body(size, context),
      ],
    );
  }

  Expanded body(Size size, BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          Container(
            child: Column(
              children: [
                Verticaldefaultpadding,
                Container(
                  width: size.width,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: kboxdecoration,
                  child: Stack(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: size.width * 0.25),
                        alignment: Alignment.center,
                        child: LocaleText("fillrate", style: Headlinestyle),
                        decoration: BoxDecoration(
                            color: ksecondrycolor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30))),
                      ),
                      Column(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //padding2(size, 0.05),
                          Verticaldefaultpadding,
                          Container(
                            margin: defaultmargin,
                            padding: defaultmargin,
                            child: TextField(
                              style: khintstyle,
                              decoration: InputDecoration(
                                  hintText: Locales.string(context, "teamno"),
                                  hintStyle: khintstyle),
                              minLines: 1,
                              maxLines: 5,
                              controller: _teamnumbercontroller,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Container(
                            margin: defaultmargin,
                            padding: defaultmargin,
                            child: TextField(
                              style: khintstyle,
                              decoration: InputDecoration(
                                  hintText: Locales.string(context, "notes"),
                                  hintStyle: khintstyle),
                              textAlign: TextAlign.start,
                              minLines: 1,
                              maxLines: 5,
                              controller: _notescontroller,
                            ),
                          ),
                          Verticaldefaultpadding
                        ],
                      ),
                    ],
                  ),
                ),
                //padding2(size, 0.1),
                Container(
                  margin: defaultmargin,
                  padding: defaultmargin,
                  decoration: kboxdecoration,
                  child: Column(
                    children: [
                      Verticaldefaultpadding,
                      rateingpercent(context),
                      rettingtext(context),
                      Verticaldefaultpadding,
                    ],
                  ),
                ),
                Verticaldefaultpadding,
                sendbutton(size, context)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Text rettingtext(BuildContext context) {
    return Text(ratetext,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: gradiant,
            ));
  }

  Row rateingpercent(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RatingBar.builder(
            minRating: 0,
            allowHalfRating: true,
            maxRating: 5,
            glow: true,
            glowColor: kprimarycolor,
            updateOnDrag: true,
            unratedColor: kprimarycolor,
            itemBuilder: (context, _) =>
                Icon(Icons.star_rounded, color: gradiant),
            onRatingUpdate: (rating) {
              setState(() {
                _rating = rating;
                if (rating <= 1) {
                  gradiant = Colors.red;
                  ratetext = Locales.lang == "en" ? "Bad" : "سيء";
                }
                if (rating > 1 && rating <= 2) {
                  gradiant = Color.fromARGB(255, 255, 171, 44);
                  ratetext = Locales.lang == "en" ? "Accept" : "مقبول";
                }
                if (rating > 2 && rating <= 3) {
                  gradiant = Colors.amber;
                  ratetext = Locales.lang == "en" ? "Good" : "جيد";
                }
                if (rating > 3 && rating <= 4) {
                  gradiant = Colors.lightGreen;
                  ratetext = Locales.lang == "en" ? "Verygood" : "جيد جداً";
                }
                if (rating > 4) {
                  gradiant = Color.fromARGB(255, 5, 241, 12);
                  ratetext = Locales.lang == "en" ? "Excellant" : "ممتاز";
                }
              });
            }),
        Text("  $_rating",
            style: Manger().styleofText(
              gradiant,
              false,
              18,
              context,
              true,
            ))
      ],
    );
  }

  Row sendbutton(Size size, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: sendbuttondecoration,
          width: size.width * 0.5,
          child: ElevatedButton(
            style: buttonStyle,
            child: buttontext,
            onPressed: () {
              setState(() {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: kprimarycolor,
                  duration: Duration(seconds: 2),
                  content: _rating > 0 &&
                          _teamnumbercontroller.text.isNotEmpty &&
                          _notescontroller.text.isNotEmpty
                      ? Text(Locales.lang == "en"
                          ? "rate has been sent successfully 👍"
                          : "تم إرسال التقييم بنجاح 👍")
                      : Text(Locales.lang == "en"
                          ? "Please fill empty fields  first"
                          : "الرجاء املأ الحقول الفارغة أولا"),
                ));
              });
            },
          ),
        )
      ],
    );
  }

  Container header(Size size, BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.topStart,
      padding: EdgeInsetsDirectional.only(start: size.width * 0.04),
      child: LocaleText('rate',
          textAlign: TextAlign.right,
          style: Manger().styleofText(
            kprimarycolor,
            false,
            size.width * 0.05,
            context,
            true,
          )),
    );
  }

  Padding padding2(Size size, double decrease) =>
      Padding(padding: EdgeInsets.only(top: size.height * decrease));
}
