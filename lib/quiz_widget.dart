import 'package:flutter/material.dart';
import 'package:times_table_workbook/quiz_provider.dart';

class QuizWidget extends StatefulWidget {
  QuizProvider provider;
  QuizWidget(this.provider, {super.key});

  @override
  State<QuizWidget> createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  @override
  Widget build(BuildContext context) {
    print("QuizWidget::build called");
    
    return Container(color: Colors.green);
  }
}
