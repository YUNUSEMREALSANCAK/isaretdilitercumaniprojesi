import 'package:flutter/material.dart';
import 'package:isaretdilitercumaniprojesi/variables.dart';

import 'Giftlistscreen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Kategoriler ve gif dosyaları
    final Map<String, List<String>> categories = {
      'Aile': [
        'assets/learn_gifs/abi.gif',
        'assets/learn_gifs/abla_1.gif',
        'assets/learn_gifs/abla_2.gif',
        'assets/learn_gifs/aile.gif',
        'assets/learn_gifs/akraba.gif',
        'assets/learn_gifs/amca.gif',
        'assets/learn_gifs/anne.gif',
        'assets/learn_gifs/anneanne.gif',
        'assets/learn_gifs/baba.gif',
      ],
      'Anatomi': [],
      'Araç Gereç': [],
      'Coğrafya': [],
      'Dini': [],
      'Diyalog': [],
      'Duygu': [],
      'Hayvan': [],
      'Matematik': [],
      'Spor': [],
    };

    return Scaffold(
        backgroundColor: CustomTheme.colorPage1 ,

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [CustomTheme.colorPage1, CustomTheme.colorPage3],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(10.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemCount: categories.keys.length,
          itemBuilder: (context, index) {
            final category = categories.keys.elementAt(index);
            return GestureDetector(
              onTap: () {
                // Kategoriye tıklandığında
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GifListPage(
                      category: category,
                      gifs: categories[category]!,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: CustomTheme.colorPage2,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text(
                    category,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}



