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
  Given that we require 3 characters on each line, the question area is 3 * 14 = 52 pixels wide

   Width: 51.0, height: 67.0 - size: 50, fontWeight: Bold
*/

/*
  Note: There is no consistency on the internet about the correct names. I 
  find the below representation more appropriate
    2     -> multiplicand
  x 5     -> multiplier
  ---
  10      -> product

*/

const int multiplicandRow = 0;
const int multiplierRow = 1;
const int answerRow = 2;

class QuizPainter extends CustomPainter {
  final int numLines = 4; // 4 logical characters per row
  final int numCharacters = 4; // 4 logical lines
  final int _lineHeight = 40; // for the graph paper...
  // With textSize 25, each character is 14.0 pixels wide and 33.0 pizels high
  final int _characterHeight = 67;
  final int _characterWidth = 51;
  final int _fontSize = 50;
  QuizItem? _item;
  Offset? _topLeft; // = const Offset(100, 100);
  Size? _currentSize;
  int _multiplier = 6;
  TextPainter? multiplierPainter;
  TextPainter? multiplySymbolPainter;
  Color pageBackgrond = const Color(0xffFAF9F6);
  late final TextStyle _textStyle;

  void setMultiplier(int multiplier) {
    _multiplier = multiplier;
  }

  void setQuizItem(QuizItem i) {
    _item = i;
  }

  Offset _offsetForRowColumn(int row, int column) {
    return Offset(_topLeft!.dx + column * _characterWidth,
        _topLeft!.dy + row * _characterHeight);
  }

  void _paintANumber(Canvas c, int number, int row, int column) {
    TextSpan ts = TextSpan(
      text: "$number",
      style: _textStyle,
    );
    TextPainter tp = TextPainter(
      text: ts,
      textAlign: TextAlign.start,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(c, _offsetForRowColumn(row, column));
  }

  void _paintNumber(int number, Canvas c, int row) {
    int hiByte = number ~/ 10; //(ans / 10).toInt();
    int loByte = number - hiByte * 10;

    if (hiByte != 0) {
      TextSpan ts = TextSpan(
        text: hiByte.toString(),
        style: _textStyle,
      );
      TextPainter tp = TextPainter(
          text: ts,
          textAlign: TextAlign.start,
          textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(c, _offsetForRowColumn(row, 1));
    }

    TextSpan ts = TextSpan(
      text: loByte.toString(),
      style: _textStyle,
    );
    TextPainter tp = TextPainter(
        text: ts, textAlign: TextAlign.start, textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(c, _offsetForRowColumn(row, 2));
  }

  void _drawMultiplicand(Canvas c) {
    int multiplicand = _item!.multiplicand;
    _paintNumber(multiplicand, c, multiplicandRow);
  }

  void _drawMultiplier(Canvas c) {
    // For now, assume that the multiplier is single digit
    if (multiplierPainter == null) {
      TextSpan ts = TextSpan(
        text: _multiplier.toString(),
        style: _textStyle,
      );
      multiplierPainter = TextPainter(
          text: ts,
          textAlign: TextAlign.start,
          textDirection: TextDirection.ltr);
      multiplierPainter!.layout();
    }
    multiplierPainter!.paint(c, _offsetForRowColumn(multiplierRow, 2));
  }

  void _drawAnswer(Canvas c) {
    Offset start = Offset(_topLeft!.dx, _topLeft!.dy + _characterHeight * 2);
    Offset end = Offset(start.dx + _characterWidth * 3, start.dy);
    Paint p = Paint();
    p.strokeWidth = 3;
    c.drawLine(start, end, p);

    start = Offset(_topLeft!.dx, _topLeft!.dy + _characterHeight * 3);
    end = Offset(start.dx + _characterWidth * 3, start.dy);
    c.drawLine(start, end, p);
    int ans = _item!.answerGiven;
    if (ans == 0) {
      return;
    }
    _paintNumber(ans, c, answerRow);
  }

  void _drawPaper(Canvas c, Size size) {
    Paint p = Paint()..color = pageBackgrond;
    Rect r = Rect.fromLTWH(0, 0, size.width, size.height);
    c.drawRect(r, p);
    p.color = Colors.lightBlue; // Color(0xffBEBEBE); //;
    int i = _lineHeight;
    while (i < size.height) {
      Offset p1 = Offset(0, i.toDouble());
      Offset p2 = Offset(size.width, i.toDouble());
      c.drawLine(p1, p2, p);
      i += _lineHeight;
    }
  }

  void _drawMultiplySymbol(Canvas c) {
    if (multiplySymbolPainter == null) {
      TextSpan ts = TextSpan(
        text: "\u00D7",
        style: _textStyle,
      );
      multiplySymbolPainter = TextPainter(
          text: ts,
          textAlign: TextAlign.start,
          textDirection: TextDirection.ltr);
      multiplySymbolPainter!.layout();
    }
    multiplySymbolPainter!.paint(c, _offsetForRowColumn(1, 0));
  }

  void _computePositions(Size size) {
    // TextSpan ts = const TextSpan(
    //     text: "W", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50));
    // TextPainter tp = TextPainter(
    //     text: ts, textAlign: TextAlign.start, textDirection: TextDirection.ltr);
    // tp.layout();
    // print("Width: ${tp.width}, height: ${tp.height}");

    _textStyle = TextStyle(
        fontSize: _fontSize.toDouble(),
        fontWeight: FontWeight.bold,
        color: Colors.black);
    _currentSize = size;
    Offset center = Offset(size.width / 2, size.height / 2);
    double left = center.dx - 3.0 * _characterWidth.toDouble() * 0.5;
    double top = center.dy - 3.0 * _characterHeight.toDouble() * 0.5;
    if (left < 0) {
      left = 0;
    }
    if (top < 0) {
      top = 0;
    }
    _topLeft = Offset(left, top);
  }

  @override
  void paint(Canvas canvas, Size size) {
    dev.log("QuizPainter::paint called with size $size");
    if (_currentSize == null || _currentSize != size) {
      _computePositions(size);
    }
    _drawPaper(canvas, size);

    if (_item != null) {
      //_displayStatus();
      _drawMultiplicand(canvas);
      _drawMultiplySymbol(canvas);
      _drawMultiplier(canvas);
      _drawAnswer(canvas);
    } else {
      dev.log("Yo! Item is null!");
    }
  }

  @override
  bool shouldRepaint(QuizPainter oldDelegate) {
    return _item != oldDelegate._item;
  }
}
