import 'package:coffee_api/views/about_screen.dart';
import 'package:coffee_api/views/card_screen.dart';
import 'package:coffee_api/views/coffee_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // default index
  int defaultIndex = 0;

  // list screens
  List<Widget> screens = [
    CoffeeScreen(),
    CardScreen(),
    AboutScreen(),
  ];

  // selected index
  void selectedIndex(newIndex) {
    defaultIndex = newIndex;
    update();
  }
}
