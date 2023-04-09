import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'chuck_norris_fact.dart';
import 'chuck_norris_page.dart';


class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late List<ChuckNorrisPage> chuckNorrisPages = [];
  final PageController pageController = PageController(keepPage: true);

  @override
  Widget build(BuildContext context) {
    final likedFacts = Hive.box("likedFacts");
    final List<ChuckNorrisFact> chuckNorrisFacts =
    likedFacts.values.toList().cast<ChuckNorrisFact>();

    // Create a list of ChuckNorrisPage widgets up front
    final List<ChuckNorrisPage> chuckNorrisPages = List.generate(
      chuckNorrisFacts.length,
          (index) {
        Color backgroundColor = [Colors.red, Colors.green, Colors.blue][index % 3];

        return ChuckNorrisPage(
          futureChuckNorrisFact: Future.value(chuckNorrisFacts[index]),
          backgroundColor: backgroundColor,
        );
      },
    );

    return
      chuckNorrisPages.isNotEmpty?
      PageView(
      controller: pageController,
      children: chuckNorrisPages,
    ): const Center(child: Text("No favourites yet",
        style: TextStyle(fontSize: 20, color: Colors.black, decoration: TextDecoration.none),),);
  }
}