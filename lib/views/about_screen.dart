import 'package:coffee_api/controllers/about_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class AboutScreen extends StatelessWidget {
  AboutScreen({super.key});

  final _aboutController = Get.put(AboutController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20.0),
          ),
        ),
        toolbarHeight: 80.0,
        title: Text(
          'About',
          style: GoogleFonts.kantumruyPro(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'images/Cafe.png',
                  height: 110.0,
                  width: 110.0,
                ),
              ),
              const SizedBox(height: 10.0),
              Center(
                child: Shimmer.fromColors(
                  baseColor: Theme.of(context).primaryColor,
                  highlightColor: Colors.pink,
                  child: Text(
                    'Coffee API',
                    style: GoogleFonts.kantumruyPro(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                'This application developed by Flutter framework with GetX state management. All the datas get from Internet.',
                style: GoogleFonts.kantumruyPro(
                  fontSize: 15.0,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 10.0),
              GestureDetector(
                onTap: (){
                  _aboutController.openURL('https://fake-coffee-api.vercel.app/');
                },
                child: Text(
                  'API url: https://fake-coffee-api.vercel.app/',
                  style: GoogleFonts.kantumruyPro(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 40.0),
              Center(
                child: Shimmer.fromColors(
                  baseColor: Theme.of(context).primaryColor,
                  highlightColor: Colors.pink,
                  child: Text(
                    'Contact : Iammrazzyy (◉_◉)',
                    style: GoogleFonts.kantumruyPro(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Shimmer.fromColors(
                baseColor: Theme.of(context).primaryColor,
                highlightColor: Colors.pink,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _aboutController.openURL('https://facebook.com/iammrazzy');
                      },
                      child: Icon(
                        Icons.facebook,
                        size: 30.0,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    GestureDetector(
                      onTap: () {
                         _aboutController.openURL('https://t.me/iammrazzy');
                      },
                      child: Icon(
                        Icons.telegram,
                        size: 30.0,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    GestureDetector(
                      onTap: () async {
                         _aboutController.openURL(
                          'mailto:riththeara103@gmail.com?subject=Your title&body=Your descriptions',
                        );
                      },
                      child: Icon(
                        Icons.email,
                        size: 30.0,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    GestureDetector(
                      onTap: () {
                         _aboutController.openURL('tel:+855 96 62 29 358');
                      },
                      child: Icon(
                        Icons.call,
                        size: 30.0,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}