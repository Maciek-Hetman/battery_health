// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final _text;

  CustomCard(this._text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      child: Card(
          child: Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          _text,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      )),
    );
  }
}
