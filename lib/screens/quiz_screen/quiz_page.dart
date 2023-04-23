import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:just_audio/just_audio.dart';
import 'package:times_table_workbook/models/quiz_results_model.dart';
import 'package:times_table_workbook/native/audio_player.dart';
import '../../app_data.dart';
import 'countdown_timer_widget.dart';
import '../../quiz_provider.dart';
import 'virtual_keyboard.dart';
import 'dart:developer' as dev;
import 'quiz_widget.dart';

class QuizPage extends StatefulWidget {
  final QuizProvider provider;
  const QuizPage(this.provider, {super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Widget? quizWidget;
  //late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    //audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    //audioPlayer.dispose();
    super.dispose();
  }

  void _startQuiz() {
    scheduleMicrotask(() {
      widget.provider.startQuiz();
    });
  }

  Widget _buildQuizOverPage(BuildContext context) {
    QuizResults qr = widget.provider.getQuizResults();
    TextStyle? ts = Theme.of(context).textTheme.bodyMedium;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Total Questions: ${qr.totalNumberOfWuestions}", style: ts),
          const SizedBox(height: 12),
          Text(
            "Correct answers: ${qr.currectAnswers}",
            style: ts,
          ),
          const SizedBox(height: 12),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Press me to continue...")),
        ],
      ),
    );
  }

  Widget _buildQuizWidget(BuildContext context) {
    quizWidget = Column(
      children: [
        const Text("StatusBar"),
        Flexible(
          flex: 7,
          child: QuizWidget(),
        ),
        Flexible(flex: 3, child: VirtualKeyboard(widget.provider)),
      ],
    );
    scheduleMicrotask(() {
      widget.provider.onQuizPainterReady();
    });
    return quizWidget!;
  }

  void _playErrorSound() async {
    AudioPlayer.playErrorNote();
    widget.provider.onSoundSetup();
  }

  void _playSuccessSound() async {
    AudioPlayer.playSuccessNote();
    widget.provider.onSoundSetup();
  }

  Widget _buildPageFromCurrentState(BuildContext context) {
    dev.log(
        "_buildPageFromCurrentState called for state [${widget.provider.state}]");
    switch (widget.provider.state) {
      case QuizState.initPending:
        return const Center(child: Text("Preparing quiz..."));
      case QuizState.quizDataReady:
        return Center(
          child: ElevatedButton(
              onPressed: () {
                _startQuiz();
              },
              child: const Text("Press me to start the quiz")),
        );
      case QuizState.beginCountdownTimer:
        return CountDownTimerWidget(widget.provider);
      case QuizState.onStartQuiz:
        return _buildQuizWidget(context);
      // case QuizState.updateCurrentItem:
      //   quizPainter.setQuizItem(widget.provider.currentQuestion());
      //   widget.provider.onCurrentItemDrawn();
//        return quizWidget!;
      case QuizState.acceptingAnswer:
        return quizWidget!;
      case QuizState.quizInProgress:
        return quizWidget!; // _buildQuizWidget(context);
      case QuizState.playErrorSound:
        _playErrorSound();
        return quizWidget!;
      case QuizState.playSuccessSound:
        _playSuccessSound();
        return quizWidget!;

      case QuizState.quizOver:
        return _buildQuizOverPage(context);
      default:
        throw Exception("Unknown state of QuizProvider!");
    }
  }

  @override
  Widget build(BuildContext context) {
    AppData data = Provider.of<AppData>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("$data.appTitle"),
      ),
      body: _buildPageFromCurrentState(context),
    );
  }
}
