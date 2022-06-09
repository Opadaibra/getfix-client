import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Mylocalcontroller extends GetxController {
  void selectlang(String lang) {
    Locale locale = Locale(lang);
    Get.updateLocale(locale);
  }
}
