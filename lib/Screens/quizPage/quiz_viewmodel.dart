import 'dart:math';
import 'quiz_model.dart';
import 'gif_service.dart';

class QuizViewModel {
  final GifService _gifService = GifService();
  QuizModel? currentQuiz;
  bool answered = false;
  String? selectedAnswer;
  bool isQuizComplete = false;

  QuizViewModel() {
    // Tüm kategorilerden 200 soru ayarla
    _gifService.setQuizParameters(
      category: 'all', // 'all' tüm kategorileri kullanır
      questionCount: 200,
    );
  }

  // Yeni soru yükle
  Future<void> loadNewQuestion() async {
    try {
      if (!_gifService.hasRemainingQuestions()) {
        isQuizComplete = true;
        return;
      }

      final gifFile = await _gifService.getRandomGif();
      // Debug için gif yolunu yazdır
      _gifService.printGifPath(gifFile);

      final correctAnswer = _gifService.getAnswerForGif(gifFile);
      final options = _gifService.getShuffledOptions(correctAnswer);

      currentQuiz = QuizModel(
        gifFile: gifFile,
        correctAnswer: correctAnswer,
        options: options,
      );
      answered = false;
      selectedAnswer = null;
    } catch (e) {
      print('Soru yükleme hatası: $e');
      // Hata durumunda mevcut soruyu koruyalım
    }
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
