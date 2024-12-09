import 'package:chakravyuh/firebase_options.dart';
import 'package:chakravyuh/pages/dashboard.dart';
import 'package:chakravyuh/pages/horoscopeNoLogin.dart';
import 'package:chakravyuh/pages/loading_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';
import 'pages/login.dart';
import 'pages/user_profile.dart';
import 'services/kundali_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => KundaliProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'ShantellSans'),
      home: const LoadingPage(),
    );
  }
}
