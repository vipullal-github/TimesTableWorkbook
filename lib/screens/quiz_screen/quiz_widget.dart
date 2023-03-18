import 'package:flutter/material.dart';
import '../../quiz_provider.dart';
import 'quiz_painter.dart';

class QuizWidget extends StatefulWidget {
  final QuizProvider provider;
  const QuizWidget(this.provider, {super.key});

  @override
  State<QuizWidget> createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  QuizPainter quizPainter = QuizPainter();

  @override
  void initState() {
    super.initState();
    quizPainter.setMultiplier(widget.provider.multiplier);
    quizPainter.setQuizItem(widget.provider.getCurrentItem());
  }

  @override
  Widget build(BuildContext context) {
    print("QuizWidget::build called");

    return CustomPaint(
      painter: quizPainter,
      child: Container(),
    );
  }
}
