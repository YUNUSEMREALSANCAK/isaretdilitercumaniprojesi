import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:isaretdilitercumaniprojesi/Screens/splash_screen.dart';
import 'services/firebase_options.dart';
//1234567890Yy

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}
