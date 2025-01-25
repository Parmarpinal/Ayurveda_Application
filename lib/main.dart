//import 'package:ayurveda/Screens/SplashScreen.dart';
import 'package:ayurveda/Screens/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:aswdc_flutter_pub/aswdc_flutter_pub.dart';
import 'package:flutter/services.dart';
import 'Screens/HomePage.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]).then((_) {
  //   runApp(MyApp());
  // });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ayurveda Application',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.green.shade700,
        appBarTheme: AppBarTheme(
            color: Colors.green.shade700,
            titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 23,
                fontWeight: FontWeight.w500
            ),
            actionsIconTheme: IconThemeData(
                color: Colors.white
            ),
            iconTheme: IconThemeData(
                color: Colors.white
            )
        ),
      ),
      home:
      const MySplashScreen(),
      //SplashScreen(appLogo: "assets/images/logo.png", appName: "Ayurveda", appVersion: "1.3"),
      debugShowCheckedModeBanner: false,
    );
  }
}
