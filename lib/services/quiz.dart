import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuizService {
  // Firestore'dan quiz verilerini çeken fonksiyon
  Future<List<Map<String, dynamic>>> fetchQuizQuestions() async {
    try {
      // Firestore'daki 'quizQuestions' koleksiyonunu alır
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('quizQuestions')
          .get();

      // Soruları ve cevapları bir liste halinde döndürür
      return querySnapshot.docs.map((doc) {
        return {
          'question': doc['question'],
          'answers': List<String>.from(doc['answers']),
          'correctAnswer': doc['correctAnswer'],
        };
      }).toList();
    } catch (e) {
      print("Hata oluştu: $e");
      return [];
    }
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late Future<List<Map<String, dynamic>>> quizData;

  @override
  void initState() {
    super.initState();
    // Firestore'dan quiz sorularını çek
    quizData = QuizService().fetchQuizQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: quizData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Bir hata oluştu'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Hiç soru yok'));
          }

          // Soruları ve cevapları ekrana getir
          var questionData = snapshot.data![0]; // İlk soruyu çek
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  questionData['question'], // Soruyu göster
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 20),
                ...questionData['answers'].map<Widget>((answer) {
                  return ElevatedButton(
                    onPressed: () {
                      // Cevap kontrolü burada yapılabilir
                      if (answer == questionData['correctAnswer']) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Doğru cevap!')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Yanlış cevap')),
                        );
                      }
                    },
                    child: Text(answer),
                  );
                }).toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}
