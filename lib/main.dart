import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:sleepfox/pages/login_page.dart';
import 'package:sleepfox/pages/main_page.dart';
import 'package:sleepfox/pages/splash_screen.dart';
import 'package:sleepfox/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFF23195F),
    ),
  );
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.thesleepfox.sleepfox',
    androidNotificationChannelName: 'SleepFox',
    androidNotificationOngoing: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "SleepFox",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: "Josefin Sans",
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: cDarkPurple,
        backgroundColor: cDarkPurple,
        dialogBackgroundColor: cDarkPurple,
      ),
      home: SplashScreen(),
    );
  }
}
