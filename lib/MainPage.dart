import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'InternetState.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool state = false;
  int selectedIndex = 0;
  WebViewController? wvc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FloatingNavbar(
        backgroundColor: Color(0xff13529E),
        onTap: (int val) async {
          if (await checkInternet() == false) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('لا يوجد اتصال بالانترنت'),
                duration: const Duration(seconds: 3),
                backgroundColor: Colors.red,
                action: SnackBarAction(
                    textColor: Colors.white,
                    label: "OK",
                    onPressed: () {
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    }),
              ),
            );

            return;
          }
          setState(() {
            selectedIndex = val;
            if (val == 0) {
              wvc?.loadUrl('https://ptc.gov.ye/?page_id=2354');
            } else if (val == 1) {
              wvc?.loadUrl('https://adsl.yemen.net.ye/');
            } else if (val == 2) {
              wvc?.loadUrl('https://ptc.gov.ye/?page_id=9017');
            } else {
              wvc?.loadUrl('https://ptc.gov.ye/?page_id=1495');
            }
          });
        },
        currentIndex: selectedIndex,
        items: [
          FloatingNavbarItem(icon: Icons.phone, title: 'الهاتف الثابت'),
          FloatingNavbarItem(
              icon: Icons.network_check_outlined, title: 'انترنت ADSL'),
          FloatingNavbarItem(
              icon: Icons.network_cell_outlined, title: '4G انترنت'),
          FloatingNavbarItem(
              icon: Icons.playlist_add_check_circle_outlined,
              title: 'المعاملات'),
        ],
      ),
      appBar: state == false
          ? AppBar(
        systemOverlayStyle:SystemUiOverlayStyle.light.copyWith(statusBarColor: Color(0xff13529E)),
              toolbarHeight: 42,
              centerTitle: true,
              elevation: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   Text("Loading",
                      style: TextStyle(color: Colors.yellow.shade900, fontSize: 18)),
                  const SizedBox(
                    width: 10,
                  ),
                  LoadingAnimationWidget.staggeredDotsWave(
                    //leftDotColor:Color(0xFF1A1A3F),
                    color: Colors.yellow.shade900,
                    //rightDotColor: const Color(0xFFEA3799),
                    size: 35,
                  ),
                ],
              ),
              backgroundColor: Colors.white,
            )
          : null,
      body: SafeArea(
        child: WebView(
          gestureNavigationEnabled: true,
          initialUrl: ("https://ptc.gov.ye/?page_id=2354"),
          allowsInlineMediaPlayback: true,
          debuggingEnabled: true,
          javascriptMode: JavascriptMode.unrestricted,
          onPageStarted: (url){
            setState(() {
              state = true;
            });
          },
          onPageFinished: (url) {
            setState(() {
              state = true;
            });
          },
          onWebViewCreated: (webComtroller) {
            setState(() {
              wvc = webComtroller;
            });
          },
          onProgress: (val) {
            setState(() {
              state = false;
            });
          },
        ),
      ),
    );
  }
}
