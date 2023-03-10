import 'dart:async';

import 'package:flutter/material.dart';
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

  void _startQuiz() {
    scheduleMicrotask(() {
      widget.provider.startQuiz();
    });
  }

  Widget _buildQuizWidget(BuildContext context) {
    quizWidget = Column(
      children: [
        Flexible(
          flex: 7,
          child: QuizWidget(widget.provider),
        ),
        Flexible(flex: 3, child: VirtualKeyboard(widget.provider)),
      ],
    );
    return quizWidget!;
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
        return _buildQuizWidget(context);
      case QuizState.quizOver:
        return Center(
          child: ElevatedButton(
              onPressed: () {}, child: const Text("Quiz over...")),
        );
      default:
        throw Exception("Unknown state of QuizProvider!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz"),
      ),
      body: _buildPageFromCurrentState(context),
    );
  }
}
