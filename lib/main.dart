import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:liveasy/presentation/pages/onboardig_page.dart';
import 'package:telephony/telephony.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'liveasy',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.white,
          // accentColor: Colors.black,
          fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}
