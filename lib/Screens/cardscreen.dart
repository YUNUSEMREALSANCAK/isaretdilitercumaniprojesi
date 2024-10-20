import 'package:flutter/material.dart';

import 'package:isaretdilitercumaniprojesi/variables.dart';

import '../component.dart';

// 1. Ana sayfa - Tam ekran kaplayan kartlar
class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1, // Kartların kare şeklinde görünmesi için
          children: const [
            ExpandedCard(imagePath: Images.images1, text: 'Orange'),
            ExpandedCard(imagePath: Images.images5, text: 'Apple'),
            ExpandedCard(imagePath: Images.images4, text: 'Banana'),
            ExpandedCard(imagePath: Images.images3, text: 'Grape'),
            ExpandedCard(imagePath: Images.images2, text: 'Grape'),
            ExpandedCard(imagePath: Images.images5, text: 'Grape'),
          ],
        ),
      ),
    );
  }
}

// Kart bileşeni: Basıldığında metin gösterme, bırakıldığında resme dönme
class ExpandedCard extends StatefulWidget {
  final String imagePath;
  final String text;

  const ExpandedCard({
    super.key,
    required this.imagePath,
    required this.text,
  });

  @override
  _ExpandedCardState createState() => _ExpandedCardState();
}

class _ExpandedCardState extends State<ExpandedCard> {
  bool _showText = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          _showText = true; // Uzun basıldığında metni göster
        });
      },
      onLongPressUp: () {
        setState(() {
          _showText = false; // Basmayı bırakınca resmi göster
        });
      },
      child: Card(
        color: CustomTheme.colorPage2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: _showText
              ? Text(
            widget.text,
            style: titleTextStyle(fontSize: 24, color: CustomTheme.black),
          )
              : Image.asset(
            widget.imagePath,
            fit: BoxFit.contain, // Resim kartın içine sığacak şekilde ayarlandı
          ),
        ),
      ),
    );
  }
}