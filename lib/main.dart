import 'package:flutter/material.dart';

import 'chuck_norris_fact.dart';
import 'chuck_norris_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late List<ChuckNorrisPage> chuckNorrisPages = [];
  final PageController pageController = PageController(keepPage: true);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.blueGrey,
            body: PageView.builder(
                controller: pageController,
                itemBuilder: (BuildContext context, int i) {
                  if (i >= chuckNorrisPages.length) {
                    while (i >= chuckNorrisPages.length) {
                      Color backgroundColor = [Colors.red, Colors.green, Colors.blue][i % 3];

                      chuckNorrisPages.add(ChuckNorrisPage(
                          futureChuckNorrisFact: fetchChuckNorrisFact(), backgroundColor: backgroundColor));
                    }
                  }
                  return chuckNorrisPages[i];
                })));
  }
}
