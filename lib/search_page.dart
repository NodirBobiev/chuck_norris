import 'dart:convert';
import 'package:chuck_norris/search_page_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'chuck_norris_fact.dart';

Future<List<ChuckNorrisFact>> fetchChuckNorrisFacts(String query) async {
  final response = await http.get(Uri.parse('https://api.chucknorris.io/jokes/search?query=$query'));

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    List<ChuckNorrisFact> chuckNorrisFacts = [];
    for(var joke in data['result']){
      chuckNorrisFacts.add(ChuckNorrisFact.fromJson(joke));
    }
    return chuckNorrisFacts;
  } else {
    throw Exception('Failed to load Chuck Norris facts ${response.statusCode} : ${response.body}');
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _onSubmitted(context) {
    final searchPageProvider = Provider.of<SearchPageProvider>(context, listen: false);
    print("search text: ${searchController.text}");
    print("provider text: ${searchPageProvider.searchText}");
    setState(() {
      if(searchController.text.length < 3) {
        searchPageProvider.set(Future.value([]), searchController.text);
      } else {
        searchPageProvider.set(fetchChuckNorrisFacts(searchController.text), searchController.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchPageProvider = Provider.of<SearchPageProvider>(context, listen: false);
    searchController.text = searchPageProvider.searchText;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey.shade200,
            ),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
              ),
              onSubmitted: (_){_onSubmitted(context);},
            ),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: FutureBuilder<List<ChuckNorrisFact>>(
              future: searchPageProvider.futureChuckNorrisFacts,
              builder: (context, snapshot) {
                if(searchController.text.length < 3) {
                  return const Center(
                    child: Text('Please enter at least three characters', style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        decoration: TextDecoration.none),),);
                }
                if (snapshot.hasData) {
                  List<ChuckNorrisFact> chuckNorrisFacts = snapshot.data!;
                  if (chuckNorrisFacts.isEmpty) {
                    return const Center(
                      child: Text('Nothing was found', style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          decoration: TextDecoration.none),),);
                  }
                  return ListView.builder(
                    controller: ScrollController(),
                    itemCount: chuckNorrisFacts.length,
                    itemBuilder: (context, index) {
                      ChuckNorrisFact chuckNorrisFact = chuckNorrisFacts[index];
                      bool liked = isFactLiked(chuckNorrisFact.id);
                      return ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          leading: IconButton(
                              iconSize: 32,
                              onPressed: () {
                                setState((){
                                  if(liked){
                                    dislikeFact(chuckNorrisFact.id);
                                  } else{
                                    likeFact(chuckNorrisFact);
                                  }
                                liked = !liked;});
                              },
                              icon: liked ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border)),
                          title: Text(
                            chuckNorrisFact.value,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.blueGrey.shade700,
                            ),
                          )
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
