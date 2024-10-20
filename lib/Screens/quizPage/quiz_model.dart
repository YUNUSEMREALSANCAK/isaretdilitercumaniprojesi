class QuizModel {
  final String videoFile;
  final String correctAnswer;
  final List<String> options;

  QuizModel({
    required this.videoFile,
    required this.correctAnswer,
    required this.options,
  });
}
