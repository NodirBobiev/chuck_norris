import 'package:chuck_norris/home_page.dart';
import 'package:chuck_norris/home_page_provider.dart';
import 'package:chuck_norris/search_page.dart';
import 'package:chuck_norris/search_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'chuck_norris_fact.dart';
import 'favourites_page.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  await Hive.initFlutter();

  Hive.registerAdapter(ChuckNorrisFactAdapter());

  await Hive.openBox('likedFacts');
  
  runApp(
     const MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;

  final List<Widget> children = [
    const HomePage(),
    const SearchPage(),
    const FavoritesPage()
  ];

  void onTabTapped(int index){
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      MultiProvider(
          providers: [
            Provider(create: (_)=>HomePageProvider()),
            Provider(create: (_)=>SearchPageProvider())
          ],
      // ChangeNotifierProvider(create: (_)=>HomePageProvider(),
    child: MaterialApp(
      home: SafeArea(
        child: Builder(
          builder: (BuildContext context) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: children[currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: currentIndex,
                onTap: onTabTapped,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'Favorites',
                  ),
                ],
              ),
            );
          },
        ),
      ),
      )
    );
  }
}
