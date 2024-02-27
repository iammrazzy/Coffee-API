import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutController extends GetxController{

  bool isLoading = false;

    // launch URL
  void openURL(String url) async {
    try {
      isLoading = true;
      update();
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(
          Uri.parse(url),
          mode: LaunchMode.externalApplication,
        );
        isLoading = false;
        update();
      } else {
        isLoading = false;
        update();
        throw 'Could not launch $url';
      }
    } catch (e) {
      isLoading = false;
      update();
      print('Error launching URL: $e');
    }
  }
}