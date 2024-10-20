import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../variables.dart';
import 'quiz_viewmodel.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final QuizViewModel _viewModel = QuizViewModel();
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _viewModel.loadNewQuestion();
    _loadVideo();
  }

  void _loadVideo() {
    final videoFile = _viewModel.currentQuiz?.videoFile;
    if (videoFile != null) {
      _controller?.dispose();
      _controller = VideoPlayerController.asset('assets/video/$videoFile')
        ..initialize().then((_) {
          setState(() {});
          _controller!.play();
        });
      _controller!.setLooping(true);
    }
  }

  void _handleAnswerSelection(String answer) {
    setState(() {
      _viewModel.selectAnswer(answer);
    });

    if (_viewModel.isAnswerCorrect()) {
      Future.delayed(const Duration(milliseconds: 500), () {
        _viewModel.loadNewQuestion();
        _loadVideo();
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
    final currentQuiz = _viewModel.currentQuiz;
    if (currentQuiz == null) return const CircularProgressIndicator();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: CustomTheme.primaryGradient,
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
            Expanded(
              child: ListView.builder(
                itemCount: currentQuiz.options.length,
                itemBuilder: (context, index) {
                  String option = currentQuiz.options[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: _viewModel.answered &&
                          _viewModel.selectedAnswer ==
                              currentQuiz.correctAnswer
                          ? null
                          : () => _handleAnswerSelection(option),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _viewModel.answered &&
                            option == currentQuiz.correctAnswer &&
                            _viewModel.selectedAnswer ==
                                currentQuiz.correctAnswer
                            ? Colors.green
                            : _viewModel.answered &&
                            option == _viewModel.selectedAnswer
                            ? Colors.red
                            : CustomTheme.colorPage2,
                        foregroundColor: CustomTheme.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        option,
                        style: const TextStyle(fontSize: 18),
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
