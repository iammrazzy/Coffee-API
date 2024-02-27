import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class NoInternetScreen extends StatelessWidget {
  NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Shimmer.fromColors(
            baseColor: Theme.of(context).primaryColor,
            highlightColor: Colors.pink,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.wifi_off_rounded,
                  size: 70.0,
                ),
                const SizedBox(height: 20.0),
                Text(
                  'No Internet Connection!',
                  style: GoogleFonts.kantumruyPro(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
