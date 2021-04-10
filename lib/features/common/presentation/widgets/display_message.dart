import 'package:flutter/material.dart';

class DisplayMessage extends StatelessWidget {
  final String message;
  final String description;

  const DisplayMessage({Key key, this.message, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(description),
        ],
      ),
    );
  }
}
