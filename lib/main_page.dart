import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:times_table_workbook/route_manager.dart';

import 'app_data.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  void _gotoQuizPage(BuildContext context) {
    Navigator.of(context).pushNamed(RouteManager.multiplierChooser);
  }

  @override
  Widget build(BuildContext context) {
    AppData data = Provider.of<AppData>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(data.appTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  _gotoQuizPage(context);
                },
                child: const Text("Take quiz")),
          ],
        ),
      ),
    );
  }
}
