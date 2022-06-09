import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:get/get.dart';
import 'package:getfix/Mywidgits/Floatingbutton.dart';
import 'package:getfix/Settings/Localcontroller.dart';
import 'package:getfix/constants/constant.dart';
import 'package:getfix/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter_restart/flutter_restart.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  List<String> _languages = ['English', 'العربية'];

  var _selectedlanguage;

  bool _darkmode = false;
  String localeText = "";
  @override
  // ignore: must_call_super
  void initState() {
    getlanguage();
  }

  @override
  Widget build(BuildContext context) {
    Mylocalcontroller controller = Get.find();
    Size size = Manger().getsize(context);
    return Scaffold(
        floatingActionButton: Floatingbutton(),
        /*dashboardappbar().Appbarwigit(context),*/
        appBar: AppBar(
          elevation: size.width * 0.25,
          toolbarHeight: size.height * 0.1,
          backgroundColor: kprimarycolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(40),
            ),
          ),
          title: LocaleText(
            "settings",
            style: Headlinestyle,
          ),
          centerTitle: true,
          //     centerTitle: true,
        ),
        body: Center(
          child: Column(
            //  mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.all(size.height * 0.01)),
              ListTile(
                title: LocaleText(
                  "lang",
                  style: TextStyle(
                      color: kprimarycolor, fontWeight: FontWeight.bold),
                ),
                leading: Icon(
                  Icons.language,
                  color: kprimarycolor,
                ),
                trailing: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    hint: Text(localeText),
                    value: _selectedlanguage,
                    onChanged: (newvalue) async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();

                      pref.setString("lang", newvalue.toString());
                      _selectedlanguage = newvalue;
                      print(_selectedlanguage);
                      if (_selectedlanguage == 'العربية') {
                        // LocaleNotifier.of(context)!.change("ar");
                        controller.selectlang("ar");
                      } else {
                        controller.selectlang("en");
                      }
                      //LocaleNotifier.of(context)!.change("en");
                      // FlutterRestart.restartApp();
                    },
                    items: _languages.map((lang) {
                      return DropdownMenuItem(
                        child: new Text(lang),
                        value: lang,
                      );
                    }).toList(),
                  ),
                ),
              ),
              Divider(
                color: kprimarycolor,
                thickness: 2,
              ),
              ListTile(
                title: LocaleText(
                  'theme',
                  style: TextStyle(
                      color: kprimarycolor, fontWeight: FontWeight.bold),
                ),
                leading: Icon(
                  Icons.light_mode,
                  color: kprimarycolor,
                ),
                trailing: Switch(
                  inactiveThumbColor: kprimarycolor,
                  activeColor: ksecondrycolor,
                  value: _darkmode,
                  focusColor: kprimarycolor,
                  onChanged: (val) async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    if (Get.isDarkMode) {
                      Get.changeTheme(ThemeData.light());
                      setState(() {
                        _darkmode = !_darkmode;
                        preferences.setBool("theme", _darkmode);
                      });
                    } else {
                      Get.changeTheme(ThemeData.dark());
                      setState(() {
                        _darkmode = !_darkmode;
                        preferences.setBool("theme", _darkmode);
                      });
                    }
                  },
                ),
              ),
              Divider(
                color: kprimarycolor,
                thickness: 2,
              ),
            ],
          ),
        ));
  }

  getlanguage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      localeText = preferences.getString("lang")!;
      try {
        _darkmode = preferences.getBool("theme")!;
      } catch (e) {
        _darkmode = false;
      }
    });
  }
}
