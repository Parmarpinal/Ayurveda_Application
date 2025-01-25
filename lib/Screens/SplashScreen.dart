import 'package:ayurveda/Screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:aswdc_flutter_pub/aswdc_flutter_pub.dart';


class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(Duration(seconds: 3)); // Duration for the splash screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()), // Your main screen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreen(appLogo: "assets/images/logo.png", appName: "Ayurveda", appVersion: "1.3"),
    );

    //   Scaffold(
    //   backgroundColor: Colors.green.shade100, // Your splash background color
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Image.asset(
    //           'assets/images/img3.png',
    //           height: 250,
    //           width: 250,
    //           color: Colors.green.shade700,
    //         ),
    //         Text('Ayurveda',style: TextStyle(color: Colors.green.shade700,fontSize: 35,fontWeight: FontWeight.w600),)
    //       ],
    //     ),
    //   ),
    // );
  }
}
