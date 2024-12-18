import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../variables.dart';
import 'Notifications.dart';

import 'cardscreen/cardscreen.dart';
import 'quizPage/quiz_page.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;

  // Her bir sayfa için bir liste
  static const List<Widget> _pages = <Widget>[
    HomePage(),
    QuizPage(),
    NotificationsPage(),
  ];

  // Seçili sayfa değiştiğinde tetiklenecek fonksiyon
  void _onItemTapped(int index) {
    if (index >= 0 && index < _pages.length) { // Güvenlik kontrolü
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomTheme.colorPage1,
        title: const Text('İşaret Dili Öğreniyorum'),
      ),
      extendBody: true, // Sayfa arkaplanını BottomNavigationBar'ın altına uzatır
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              CustomTheme.colorPage1,
              CustomTheme.colorPage3,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.magnifyingGlass),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.bell),
            label: 'Notifications',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: CustomTheme.colorPage3, // Seçili ikon rengi
        unselectedItemColor: CustomTheme.colorPage1, // Seçilmemiş ikon rengi
        backgroundColor: Colors.transparent, // Şeffaf arkaplan
        elevation: 0.5, // Gölgeyi kaldır
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
