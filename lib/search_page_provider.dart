import 'package:flutter/material.dart';

import 'chuck_norris_fact.dart';
// import 'chuck_norris_page.dart';

class SearchPageProvider extends ChangeNotifier {
  late Future<List<ChuckNorrisFact>> futureChuckNorrisFacts;
  String searchText = "";

  SearchPageProvider(){
    futureChuckNorrisFacts = Future.value([]);
    searchText = "";
  }

  void set(Future<List<ChuckNorrisFact>> futureFacts, String text){
    futureChuckNorrisFacts = futureFacts;
    searchText = text;
  }
}