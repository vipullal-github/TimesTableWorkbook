import 'package:flutter/material.dart';
import 'quiz_provider.dart';

class VirtualKeyboard extends StatefulWidget {
  QuizProvider provider;
  VirtualKeyboard(this.provider, {super.key});

  @override
  State<VirtualKeyboard> createState() => _VirtualKeyboardState();
}

class _VirtualKeyboardState extends State<VirtualKeyboard> {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.red);
  }
}
