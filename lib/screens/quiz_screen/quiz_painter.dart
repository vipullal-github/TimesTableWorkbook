import 'package:flutter/material.dart';
import '../../quiz_data.dart';
import 'dart:developer' as dev;

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

/*
  For font size set to 25, each character is 14 pixels wide and 33 pixels high.
  If we approximate the character size to be 15w * 35h, we can calculate the position of every 
  character in the display. 
  Given 3 lines to display the entire question, our display is 3 * 33 + 10 = 110 pixels high
  Given that we require 3 characters on each line, the question area is 3 * 14 = 52 pixels wid 
*/

class QuizPainter extends CustomPainter {
  final int lineHeight = 40;
  // With textSize 25, each character is 14.0 pixels wide and 33.0 pizels high
  final int textSize = 25;
  QuizItem? item;
  Size logicalCharacterSize = const Size(15, 35);
  Offset topLeft = const Offset(100, 100);
  int multiplier = 6;
  TextPainter? multiplierPainter;
  TextPainter? multiplySymbolPainter;
  List<TextPainter>? keyboardPainters;
  Color pageBackgrond = const Color(0xffFAF9F6);

  void setMultiplier(int multiplier) {
    multiplier = multiplier;
  }

  void setQuizItem(QuizItem i) {
    item = i;
  }

  void _drawMultiplicand(Canvas c, Size size) {
    TextSpan ts = TextSpan(
      text: "$item!multiplicand",
    );
  }

  Offset _offsetForRowColumn(int row, int column) {
    return Offset(topLeft.dx + column * logicalCharacterSize.width,
        topLeft.dy + row * logicalCharacterSize.height);
  }

  void _drawMultiplier(Canvas c) {
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
    multiplierPainter!.paint(c, _offsetForRowColumn(0, 0));
  }

  void _drawAnswer(Canvas c, Size size) {}

  void drawKeyboard(Canvas c) {
    if (keyboardPainters == null) {}
  }

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

  void _drawMultiplySymbol(Canvas c) {
    if (multiplySymbolPainter == null) {
      TextSpan ts = TextSpan(
        text: "X",
        style: TextStyle(fontSize: textSize.toDouble(), color: Colors.black),
      );
      multiplySymbolPainter = TextPainter(
          text: ts,
          textAlign: TextAlign.start,
          textDirection: TextDirection.ltr);
      multiplySymbolPainter!.layout();
    }
    multiplySymbolPainter!.paint(c, _offsetForRowColumn(1, 0));
  }

  @override
  void paint(Canvas canvas, Size size) {
    dev.log("QuizPainter::paint called with size $size");
    _drawPaper(canvas, size);

    if (item != null) {
      _drawMultiplicand(canvas, size);
      _drawMultiplySymbol(canvas);
      _drawMultiplier(canvas);
      _drawAnswer(canvas, size);
    }
  }

  @override
  bool shouldRepaint(QuizPainter oldDelegate) {
    return item != oldDelegate.item;
  }
}
