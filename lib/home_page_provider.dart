import 'package:flutter/material.dart';

import 'chuck_norris_fact.dart';
import 'chuck_norris_page.dart';

class HomePageProvider extends ChangeNotifier {
  late final List<ChuckNorrisPage> _chuckNorrisPages = [];
  int currentIndex = 0;

  List<ChuckNorrisPage> get chuckNorrisPages => _chuckNorrisPages;

  void addChuckNorrisPage(Color backgroundColor) {
    _chuckNorrisPages.add(
      ChuckNorrisPage(
        futureChuckNorrisFact: fetchChuckNorrisFact(),
        backgroundColor: backgroundColor,
      ),
    );
  }

  void removeChuckNorrisPage(int index) {
    _chuckNorrisPages.removeAt(index);
    notifyListeners();
  }

  void updateCurrentIndex(int index){
    currentIndex = index;
    notifyListeners();
  }
}