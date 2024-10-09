import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:isaretdilitercumaniprojesi/services/quiz.dart';
import 'package:isaretdilitercumaniprojesi/variables.dart';
import 'package:isaretdilitercumaniprojesi/appHome/cardscreen.dart';

import 'Notifications.dart';
import 'Profile.dart';

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
    ProfilePage(email: 'user@example.com'),
  ];

  // Seçili sayfa değiştiğinde tetiklenecek fonksiyon
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Navigation Example'),
        backgroundColor: CustomTheme.colorPage1,
      ),
      body: Center(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house),
            label: 'Home',
            backgroundColor: CustomTheme.colorPage1,
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.magnifyingGlass),
            label: 'Search',
            backgroundColor: CustomTheme.colorPage2,
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.bell),
            label: 'Notifications',
            backgroundColor: CustomTheme.colorPage3,
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user),
            label: 'Profile',
            backgroundColor: CustomTheme.colorPage1,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: CustomTheme.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

