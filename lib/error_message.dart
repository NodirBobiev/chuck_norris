import 'package:flutter/material.dart';

class ErrorMessageWidget extends StatelessWidget {
  final String errorMessage;

  const ErrorMessageWidget({Key? key, required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Oops, something went wrong. Please, try again! $errorMessage',
              style: const TextStyle(fontSize: 20, color: Colors.white, decoration: TextDecoration.none),
            )));
  }
}
