import 'package:flutter/material.dart';

import '../variables.dart';

// Diğer sayfalar (Search ve Notifications boş bırakıldı)
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [CustomTheme.colorPage1, CustomTheme.colorPage2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(
        child: Text(
          'Search Page',
          style: TextStyle(fontSize: 24, color: CustomTheme.black),
        ),
      ),
    );
  }
}

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [CustomTheme.colorPage3, CustomTheme.colorPage1],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(
        child: Text(
          'Notifications Page',
          style: TextStyle(fontSize: 24, color: CustomTheme.black),
        ),
      ),
    );
  }
}
