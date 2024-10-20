import 'dart:math';

import 'quiz_viewmodel.dart';


class VideoService {
  // Rastgele bir video dosyası seç
  String getRandomVideo() {
    final random = Random();
    return videoToAnswer.keys.elementAt(random.nextInt(videoToAnswer.length));
  }

  // Belirli bir videonun doğru cevabını al
  String getAnswerForVideo(String videoFile) {
    return videoToAnswer[videoFile]!;
  }

  // Yanlış ve karışık şıklar elde et
  List<String> getShuffledOptions(String correctAnswer) {
    List<String> options = List.from(wordBank)..remove(correctAnswer);
    options.shuffle();
    return options.take(3).toList();
  }
}
