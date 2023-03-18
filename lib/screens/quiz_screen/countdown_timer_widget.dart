import 'dart:async';

import 'package:flutter/material.dart';
import 'package:times_table_workbook/quiz_provider.dart';

// ignore: must_be_immutable
class CountDownTimerWidget extends StatefulWidget {
  QuizProvider provider;
  CountDownTimerWidget(this.provider, {super.key});

  @override
  State<CountDownTimerWidget> createState() => _CountDownTimerWidgetState();
}

class _CountDownTimerWidgetState extends State<CountDownTimerWidget> {
  int count = 3;
  late Timer _countDownTimer;

  @override
  void initState() {
    super.initState();
    _countDownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (count == 1) {
        _countDownTimer.cancel();
        widget.provider.onCountdownComplete();
      } else {
        setState(() => count = count - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(count.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 50)),
    );
  }
}
