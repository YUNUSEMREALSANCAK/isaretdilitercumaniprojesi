import 'package:flutter/material.dart';
import 'package:isaretdilitercumaniprojesi/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Screens/navigation.dart';
import 'information_about_app_screen/information_about_app_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus(); // Oturum durumunu kontrol ediyoruz
  }

  // Oturum durumunu kontrol eden fonksiyon
  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    // Eğer oturum açılmışsa Navigation sayfasına yönlendir
    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Navigation()),
      );
    } else {
      // Eğer oturum açılmamışsa SignIn sayfasına yönlendir
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: CustomTheme.primaryGradient, // Arka plan rengi olarak primaryGradient
        ),
        child: Center(
          child: Image.asset(
            Images.images1, // Logo olarak image-1.png kullanılıyor
            width: 150, // İsteğe göre boyutlandırma
            height: 150,
          ),
        ),
      ),
    );
  }
}
