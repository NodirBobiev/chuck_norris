import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_page_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homePageProvider = Provider.of<HomePageProvider>(context);

    return PageView.builder(
      controller: PageController(initialPage: homePageProvider.currentIndex),
      onPageChanged: (index){
        homePageProvider.updateCurrentIndex(index);
      },
      itemBuilder: (BuildContext context, int i) {
        if (i >= homePageProvider.chuckNorrisPages.length) {
          while (i >= homePageProvider.chuckNorrisPages.length) {
            Color backgroundColor = [Colors.red, Colors.green, Colors.blue][i % 3];

            homePageProvider.addChuckNorrisPage(backgroundColor);
          }
        }
        return homePageProvider.chuckNorrisPages[i];
      },
    );
  }
}