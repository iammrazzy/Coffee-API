import 'package:coffee_api/controllers/network_controller.dart';
import 'package:coffee_api/injections/dependency_injection.dart';
import 'package:coffee_api/views/home.dart';
import 'package:coffee_api/views/no_internet_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main(){
  // check internet connection injec in the whole app
  DependencyInjection.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _networkController = Get.put(NetworkController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Coffee API - (fetch data from the internet) | Flutter + GetX state management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.cyan,
        useMaterial3: true,
      ),
      home: GetBuilder<NetworkController>(
        builder: (_) {
          return _networkController.isConnected ? Home() : NoInternetScreen();
        },
      ),
    );
  }
}
