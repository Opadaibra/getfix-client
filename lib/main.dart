import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:get/get.dart';
import 'package:getfix/Settings/Localcontroller.dart';
import 'package:getfix/View/LogIn//LoginPage.dart';
import 'package:flutter/services.dart';
import 'package:getfix/constants/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Locales.init(['en', 'ar']);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Get.put(Mylocalcontroller());
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    ThemeData lighttheme = ThemeData(
      shadowColor: Colors.grey[200],
      primaryColor: kprimarycolor,
      backgroundColor: Colors.white,
      dividerColor: Colors.white54,
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey)
          .copyWith(secondary: Color(0xffFF715A)),
    );
    // ignore: unused_local_variable
    ThemeData darktheme = ThemeData(
      primaryColor: Color(0xFF053F5E),
      backgroundColor: const Color(0xFF212121),
      dividerColor: Colors.black12,
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
          .copyWith(secondary: Color(0xff4B89F1)),
    );
    return LocaleBuilder(
      builder: (locale) => GetMaterialApp(
        localizationsDelegates: Locales.delegates,
        supportedLocales: Locales.supportedLocales,
        locale: locale,
        debugShowCheckedModeBanner: false,
        title: 'Client',
        theme: lighttheme,
        home: LoginPage(),
      ),
    );
  }
}
