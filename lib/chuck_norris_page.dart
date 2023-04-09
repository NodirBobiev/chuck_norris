import 'package:flutter/material.dart';
import 'chuck_norris_fact.dart';
import 'dart:async';
import 'error_message.dart';

class ChuckNorrisPage extends StatefulWidget {
  final Future<ChuckNorrisFact> futureChuckNorrisFact;
  final Color backgroundColor;

  const ChuckNorrisPage({Key? key, required this.futureChuckNorrisFact, required this.backgroundColor})
      : super(key: key);

  @override
  State<ChuckNorrisPage> createState() => _ChuckNorrisPageState();
}

class _ChuckNorrisPageState extends State<ChuckNorrisPage> {
  bool showHeartOverlay = false;
  bool liked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: widget.backgroundColor,
        child: FutureBuilder<ChuckNorrisFact>(
          future: widget.futureChuckNorrisFact,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _buildChuckNorrisFact(snapshot.data!);
            } else if (snapshot.hasError) {
              return ErrorMessageWidget(errorMessage: snapshot.error!.toString());
            }
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            ));
          },
        ));
  }

  Widget _buildChuckNorrisFact(chuckNorrisFact) {
    liked = isFactLiked(chuckNorrisFact.id);
    return Stack(children: [
      GestureDetector(
        onDoubleTap: () {
          setState(() {
            if (!showHeartOverlay) {
              showHeartOverlay = true;
              Timer(const Duration(milliseconds: 500), () => setState(() => showHeartOverlay = false));
            }
            liked = true;
            likeFact(chuckNorrisFact);
          });
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 320,
                    width: 320,
                    child: Image.asset(chuckNorrisFact.image),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        chuckNorrisFact.value,
                        style: const TextStyle(fontSize: 20, color: Colors.white, decoration: TextDecoration.none),
                      ))
                ]),
            showHeartOverlay
                ? const Icon(
                    Icons.favorite,
                    color: Color.fromARGB(203, 255, 255, 255),
                    size: 80,
                  )
                : Container()
          ],
        ),
      ),
      Padding(
          padding: const EdgeInsets.all(16.0),
          child: IconButton(
              iconSize: 50,
              onPressed: () {
                setState((){
                  if(liked){
                    dislikeFact(chuckNorrisFact.id);
                  } else{
                      likeFact(chuckNorrisFact);
                  }
                  liked = !liked;});
              },
              icon: liked ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border)))
    ]);
  }
}
