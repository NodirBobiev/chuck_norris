import 'dart:convert';
import 'package:http/http.dart' as http;

Future<ChuckNorrisFact> fetchChuckNorrisFact() async {
  final response = await Future.delayed(
      const Duration(seconds: 0), () => http.get(Uri.parse('https://api.chucknorris.io/jokes/random')));

  if (response.statusCode == 200) {
    return ChuckNorrisFact.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load a Chuck Norris fact ${response.statusCode} : ${response.body}');
  }
}

class ChuckNorrisFact {
  final String image;
  final String id;
  final String url;
  final String value;

  static List chuckNorrisImages = ['assets/images/chuck_norris1.png', 'assets/images/chuck_norris2.png'];
  static int counter = 0;

  ChuckNorrisFact({required this.image, required this.id, required this.url, required this.value});

  factory ChuckNorrisFact.fromJson(Map<String, dynamic> json) {
    counter++;
    return ChuckNorrisFact(
        image: chuckNorrisImages[counter % 2], id: json['id'], url: json['url'], value: json['value']);
  }
}
