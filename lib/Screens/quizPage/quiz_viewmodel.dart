import 'dart:math';
import 'quiz_model.dart';
import 'video_service.dart';


class QuizViewModel {
  final VideoService _videoService = VideoService();
  QuizModel? currentQuiz;
  bool answered = false;
  String? selectedAnswer;

  // Yeni soru yükle
  void loadNewQuestion() {
    final random = Random();
    final videoFile = _videoService.getRandomVideo();
    final correctAnswer = _videoService.getAnswerForVideo(videoFile);

    List<String> options = _videoService.getShuffledOptions(correctAnswer);
    options.insert(random.nextInt(4), correctAnswer);

    currentQuiz = QuizModel(
      videoFile: videoFile,
      correctAnswer: correctAnswer,
      options: options,
    );
    answered = false;
    selectedAnswer = null;
  }

  // Şık seçimi
  void selectAnswer(String answer) {
    selectedAnswer = answer;
    answered = true;
  }

  bool isAnswerCorrect() {
    return selectedAnswer == currentQuiz?.correctAnswer;
  }
}

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