import 'package:flutter/material.dart';

import '../../variables.dart';

class GifListPage extends StatelessWidget {
  final String category;
  final List<String> gifs;

  const GifListPage({
    super.key,
    required this.category,
    required this.gifs,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomTheme.colorPage1,
        title: Text(category),

      ),
      body: gifs.isEmpty
          ? const Center(
        child: Text('Bu kategoride henüz gif bulunmamaktadır.'),
      )
          : Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [CustomTheme.colorPage1, CustomTheme.colorPage3],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
            child: ListView.builder(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: gifs.length,
                    itemBuilder: (context, index) {
            final gifPath = gifs[index];
            final gifName = gifPath.split('/').last.split('.').first;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
               // crossAxisAlignment: CrossAxisAlignment.center, // Tüm öğeleri yatay olarak ortala
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(gifPath),
                  const SizedBox(height: 8.0),
                  Text(
                    textAlign: TextAlign.center,
                    gifName,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                 // const Divider(),
                ],
              ),
            );
                    },
                  ),
          ),
    );
  }
}