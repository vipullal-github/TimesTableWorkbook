import 'package:flutter/material.dart';
import '../../quiz_provider.dart';

class VirtualKeyboard extends StatefulWidget {
  final QuizProvider provider;
  const VirtualKeyboard(this.provider, {super.key});

  @override
  State<VirtualKeyboard> createState() => _VirtualKeyboardState();
}

class _VirtualKeyboardState extends State<VirtualKeyboard> {
  List<String> keys = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    'Ok',
    'Bsp'
  ];
  Widget _buildNumbersRow() {
    List<Widget> btnRow = List.generate(
      keys.length,
      (int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            child: Text(keys[index]),
            onPressed: () {
              widget.provider.onKeyPressed(keys[index]);
            },
          ),
        );
      },
    );

    return Wrap(
      children: btnRow,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      return Container(
        child: _buildNumbersRow(),
      );
    });
  }
}
