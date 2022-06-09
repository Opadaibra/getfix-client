import 'package:get/get.dart';

class AddsiteController extends GetxController {
  // It is mandatory initialize with one value from listType
  var selectedDrowpdown = 'دمشق';
  String selectedcity = 'المزة';

  List Mylist = [
    "دمشق",
    "درعا",
    "السويداء",
    "حمص",
    "طرطوس",
    "اللاذقية",
    "حلب",
    "الحسكة",
    "الرقة",
    "دير الزور"
  ];
  List citylist = [
    "المزة",
    "درعا",
    "السويداء",
    "حمص",
    "طرطوس",
    "اللاذقية",
    "حلب",
    "الحسكة",
    "الرقة",
    "دير الزور"
  ];

  void selectGov(String selectdvalue) {
    selectedDrowpdown = selectdvalue;
    update();
  }

  void selectcity(String selectdvalue) {
    selectedDrowpdown = selectdvalue;
    update();
  }
}
