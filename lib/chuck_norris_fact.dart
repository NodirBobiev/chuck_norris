import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
part 'chuck_norris_fact.g.dart';

Future<ChuckNorrisFact> fetchChuckNorrisFact() async {
  final response = await http.get(Uri.parse('https://api.chucknorris.io/jokes/random'));

  if (response.statusCode == 200) {
    return ChuckNorrisFact.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load a Chuck Norris fact ${response.statusCode} : ${response.body}');
  }
}

bool isFactLiked(String chuckNorrisFactId){
  final likedFacts = Hive.box("likedFacts");
  return likedFacts.containsKey(chuckNorrisFactId);
}

void likeFact(ChuckNorrisFact chuckNorrisFact){
  final likedFacts = Hive.box("likedFacts");
  likedFacts.put(chuckNorrisFact.id, chuckNorrisFact);
}

void dislikeFact(String chuckNorrisFactId){
  final likedFacts = Hive.box("likedFacts");
  likedFacts.delete(chuckNorrisFactId);
}

@HiveType(typeId: 0)
class ChuckNorrisFact {
  @HiveField(0)
  final String image;

  @HiveField(1)
  final String id;

  @HiveField(2)
  final String url;

  @HiveField(3)
  final String value;

  ChuckNorrisFact({required this.image, required this.id, required this.url, required this.value});

  factory ChuckNorrisFact.fromJson(Map<String, dynamic> json) {
    counter += 1;
    return ChuckNorrisFact(
        image: chuckNorrisImages[counter % 2], id: json['id'], url: json['url'], value: json['value']);
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'id': id,
      'url': url,
      'value': value,
    };
  }

  static List<String> chuckNorrisImages = ['assets/images/chuck_norris1.png', 'assets/images/chuck_norris2.png'];
  static int counter = 0;
}