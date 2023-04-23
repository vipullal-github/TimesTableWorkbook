import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_data.dart';

class PracticeScreen extends StatelessWidget {
  const PracticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppData data = Provider.of<AppData>(context, listen: false);
    final int multiplier = data.lastTable;
    final List<Widget> items = [];
    for (int i = 1; i < 10; i++) {
      Card c = Card(
        child: Text("$i x $multiplier = ${i * multiplier}"),
      );
      items.add(c);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(data.appTitle),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: ListView(
              children: items,
            ),
          ),
        ],
      ),
    );
  }
}
