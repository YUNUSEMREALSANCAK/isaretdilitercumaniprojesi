import 'package:flutter/material.dart';
import 'dart:async'; // Otomatik geçiş için
import 'dart:math';
import 'package:video_player/video_player.dart';
import '../variables.dart';



// Rastgele şıklar oluştururken kullanacağımız kelimeler
const List<String> wordBank = [
  'agac', 'aglamak', 'aksam', 'aksamyemegi', 'amca', 'araba', 'armut', 'asci',
  'at', 'atm', 'baba', 'balik', 'bebek', 'bilgisayar', 'bilgisayarekrani',
  'bugun', 'ceza', 'ekran', 'hapishane', 'kamera', 'kocburcu', 'mavi', 'mor',
  'muhendis', 'para'
];

// Her videonun doğru cevabı ile eşleşmesini sağlayan yapı
const Map<String, String> videoToAnswer = {
  'agac.mp4': 'agac',
  'aglamak.mp4': 'aglamak',
  'aksam.mp4': 'aksam',
  'aksamyemegi.mp4': 'aksamyemegi',
  'amca.mp4': 'amca',
  'araba.mp4': 'araba',
  'armut.mp4': 'armut',
  'asci.mp4': 'asci',
  'at.mp4': 'at',
  'atm.mp4': 'atm',
  'baba.mp4': 'baba',
  'balik.mp4': 'balik',
  'bebek.mp4': 'bebek',
  'bilgisayar.mp4': 'bilgisayar',
  'bilgisayarekrani.mp4': 'bilgisayarekrani',
  'bugun.mp4': 'bugun',
  'ceza.mp4': 'ceza',
  'ekran.mp4': 'ekran',
  'hapishane.mp4': 'hapishane',
  'kamera.mp4': 'kamera',
  'kocburcu.mp4': 'kocburcu',
  'mavi.mp4': 'mavi',
  'mor.mp4': 'mor',
  'muhendis.mp4': 'muhendis',
  'para.mp4': 'para',
};

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  VideoPlayerController? _controller;
  String currentAnswer = '';
  String? selectedAnswer;
  bool answered = false;
  List<String> currentOptions = [];

  @override
  void initState() {
    super.initState();
    loadNewQuestion();
  }

  // Yeni soruyu ve şıkları yükleyen fonksiyon
  void loadNewQuestion() {
    final random = Random();
    final videoFile = videoToAnswer.keys.elementAt(random.nextInt(videoToAnswer.length));
    final correctAnswer = videoToAnswer[videoFile]!;

    // Rastgele diğer yanlış cevapları seçiyoruz
    List<String> options = List.from(wordBank)..remove(correctAnswer);
    options.shuffle();
    List<String> wrongAnswers = options.take(3).toList();

    // Doğru cevabı rastgele bir pozisyona yerleştiriyoruz
    wrongAnswers.insert(random.nextInt(4), correctAnswer);

    setState(() {
      currentAnswer = correctAnswer;
      answered = false;
      selectedAnswer = null;
      currentOptions = wrongAnswers;

      _controller?.dispose();
      _controller = VideoPlayerController.asset('assets/video/$videoFile')
        ..initialize().then((_) {
          setState(() {});
          _controller!.play();
        });
      _controller!.setLooping(true); // Videonun sürekli tekrar etmesini sağla
    });
  }

  // Şık seçimi
  void selectAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
      answered = true;
    });

    // Cevap doğru ise 0.5 saniye sonra yeni soruya geç
    if (answer == currentAnswer) {
      Future.delayed(const Duration(milliseconds: 500), () {
        loadNewQuestion();
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: CustomTheme.primaryGradient, // Arka plan gradyanı
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _controller != null && _controller!.value.isInitialized
                ? AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: VideoPlayer(_controller!),
            )
                : const Center(child: CircularProgressIndicator()),
            const SizedBox(height: 20),
            const Text(
              'Yukarıda gösterilen işaret hangi kelimeye karşılık gelir?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: CustomTheme.black,
              ),
            ),
            const SizedBox(height: 10),
            // Şıklar
            Expanded(
              child: ListView.builder(
                itemCount: currentOptions.length,
                itemBuilder: (context, index) {
                  String option = currentOptions[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: answered && selectedAnswer == currentAnswer
                          ? null // Eğer doğru cevabı bulduysa artık basılmasın
                          : () => selectAnswer(option),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: answered && option == currentAnswer && selectedAnswer == currentAnswer
                              ? Colors.green // Doğru şık sadece doğru cevaplandığında yeşil
                              : answered && option == selectedAnswer
                              ? Colors.red // Yanlış şık kırmızı
                              : CustomTheme.colorPage2, // Varsayılan renk
                        foregroundColor: CustomTheme.black, // Yazı rengi
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // Buton köşelerini yuvarla
                        ),
                      ),
                      child: Text(
                        option,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
