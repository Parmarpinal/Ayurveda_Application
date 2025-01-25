import 'package:flutter/material.dart';
import 'package:aswdc_flutter_pub/aswdc_flutter_pub.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});
  final String _appUrl = 'https://play.google.com/store/apps/details?id=com.aswdc_ayurveda';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DeveloperScreen(
        developerName: 'Pinal Parmar (22010101136)',
        mentorName: 'Prof. Rajkumar Gondaliya',
        exploredByName: 'ASWDC',
        isAdmissionApp: false,
        isDBUpdate: false,
        shareMessage: "Download Ayurveda app from Google Play Store. $_appUrl",
        appTitle: 'Ayurveda',
        appLogo: 'assets/images/logo.png',
        androidAPPURL: 'https://play.google.com/store/apps/details?id=com.aswdc_ayurveda',
        iosAPPURL: '',
      ),
    );
  }
}
