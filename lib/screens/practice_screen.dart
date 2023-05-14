import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:times_table_workbook/my_app_bar.dart';

import '../app_data.dart';

class PracticeScreen extends StatelessWidget {
  const PracticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppData data = Provider.of<AppData>(context, listen: false);
    final int multiplier = data.lastTable;
    //final BorderRadiusGeometry cardBorder = BorderRadius.circular(15.0);
    final TextStyle ts =
        Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 35);
    final List<Widget> items = [];
    for (int i = 1; i < 10; i++) {
      Card c = Card(
        //shape: RoundedRectangleBorder(borderRadius: cardBorder),
        color: Colors.lightBlue,
        elevation: 10.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "$i x $multiplier = ${i * multiplier}",
            style: ts,
          ),
        ),
      );
      items.add(c);
    }

    return Scaffold(
      appBar: MyAppBar( screenName: data.appTitle),
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
