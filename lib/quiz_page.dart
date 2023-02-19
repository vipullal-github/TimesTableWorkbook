import 'dart:async';

import 'package:flutter/material.dart';
import 'package:times_table_workbook/quiz_provider.dart';
import 'dart:developer' as dev;
import 'quiz_data.dart';

class QuizPage extends StatefulWidget {
  QuizProvider provider;
  QuizPage(this.provider, {super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuizPainter painter = QuizPainter();

  @override
  void initState() {
    super.initState();
    painter.setMultiplier(6);
  }

  void _startQuiz() {
    scheduleMicrotask(() {
      widget.provider.startQuiz();
    });
  }

  Widget _quizWidget(BuildContext context) {
    return Column(
      children: [
        Flexible(
            child: LayoutBuilder(
                builder: (_, c) => SizedBox(
                    height: c.maxHeight,
                    width: c.maxWidth,
                    child: CustomPaint(painter: painter))))
      ],
    );
  }

  Widget _buildPage(BuildContext context) {
    switch (widget.provider.state) {
      case QuizState.initPending:
        scheduleMicrotask(() {
          widget.provider.prepareQuiz();
        });
        return const Center(child: Text("Preparing quiz..."));
      case QuizState.paused:
        return Center(
          child: ElevatedButton(
              onPressed: () {
                _startQuiz();
              },
              child: const Text("Press me to continue")),
        );
      case QuizState.quizInProgress:
        return _quizWidget(context);
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
        body: _buildPage(context));
  }
}

/*
final span = TextSpan(
      style: style ?? chartValueStyle,
      text: name,
    );
    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout()
    tp.paint( Canvas, Offset)
*/

class QuizPainter extends CustomPainter {
  final int lineHeight = 40;
  final int textSize =
      25; // each character is 14.0 pixels wide and 33.0 pizels high
  QuizItem? item;
  int multiplier = 96;
  TextPainter? multiplierPainter;
  Color pageBackgrond = const Color(0xffFAF9F6);

  void setMultiplier(int multiplier) {
    multiplier = multiplier;
  }

  void setQuizItem(QuizItem i) {
    item = i;
  }

  void _drawMultiplicand(Canvas c, Size size) {}

  void _drawMultiplier(Canvas c, Size size) {
    dev.log("QuizPaint::_drawMultiplier called");
    if (multiplierPainter == null) {
      TextSpan ts = TextSpan(
        text: multiplier.toString(),
        style: TextStyle(fontSize: textSize.toDouble(), color: Colors.black),
      );
      multiplierPainter = TextPainter(
          text: ts,
          textAlign: TextAlign.start,
          textDirection: TextDirection.ltr);
      multiplierPainter!.layout();
    }
    Offset offset = Offset(0, 0);
    multiplierPainter!.paint(c, offset);
  }

  void _drawAnswer(Canvas c, Size size) {}

  void _drawPaper(Canvas c, Size size) {
    Paint p = Paint()..color = pageBackgrond;
    Rect r = Rect.fromLTWH(0, 0, size.width, size.height);
    c.drawRect(r, p);
    p.color = Colors.lightBlue; // Color(0xffBEBEBE); //;
    int i = lineHeight;
    while (i < size.height) {
      Offset p1 = Offset(0, i.toDouble());
      Offset p2 = Offset(size.width, i.toDouble());
      c.drawLine(p1, p2, p);
      i += lineHeight;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    dev.log("QuizPainter::paint called with size $size");
    _drawPaper(canvas, size);
    _drawMultiplicand(canvas, size);
    _drawMultiplier(canvas, size);
    _drawAnswer(canvas, size);
  }

  @override
  bool shouldRepaint(QuizPainter oldDelegate) => true;
}
