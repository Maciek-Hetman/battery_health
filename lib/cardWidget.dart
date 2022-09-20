import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final _text;

  CustomCard(this._text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          _text,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      )),
    );
  }
}
