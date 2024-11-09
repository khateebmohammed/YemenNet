import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yemennet/MainPage.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         toolbarHeight: 0,
        systemOverlayStyle:SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.blue.shade400),
        elevation: 0,

      ),
      body: SafeArea(
        child: EasySplashScreen(
          showLoader: true,
          loaderColor: Colors.white,
          gradientBackground: LinearGradient(colors: [
            Colors.blue.shade400,
            Colors.blue,
            Colors.blue.shade600,
            Colors.blue.shade700,
            Colors.blue.shade800,
            Colors.blue.shade900
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          logoWidth: MediaQuery.of(context).size.width / 5,
          loadingText: Text(
            "الاستعلام عن الرصيد\n(4G، الهاتف الأرضي، انترنت ADSL، المعاملات)",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          durationInSeconds: 4,
          title: Text(
            'Yemen Net',
            style: TextStyle(
                fontSize: 22, color: Colors.white, fontStyle: FontStyle.italic),
          ),
          navigator: const MainPage(),
          logo: Image.asset(
            'images/internet.png',
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
