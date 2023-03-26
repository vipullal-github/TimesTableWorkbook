import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../quiz_provider.dart';
import 'quiz_painter.dart';
import 'dart:developer' as dev;

class QuizWidget extends StatelessWidget {
  final QuizPainter quizPainter = QuizPainter();

  QuizWidget({super.key});

  Widget _quizOverPage(context) {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    dev.log("QuizWidget::build called");
    QuizProvider provider = Provider.of<QuizProvider>(context);
    if (provider.state == QuizState.quizOver) {
      scheduleMicrotask(() {
        Navigator.of(context).pop();
      });
      return _quizOverPage(context);
    }
    quizPainter.setMultiplier(provider.multiplier);
    quizPainter.setQuizItem(provider.getCurrentItem());
    return CustomPaint(
      painter: quizPainter,
      child: Container(),
    );
  }
}
