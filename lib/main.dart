import 'package:chakravyuh/firebase_options.dart';
import 'package:chakravyuh/pages/compatibility/compatibility_result.dart';
import 'package:chakravyuh/pages/onboarding/loading_page.dart';
import 'package:chakravyuh/pages/onboarding/percent_loader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'ShantellSans'),
      home: LoadingPage(),
    );
  }
}
