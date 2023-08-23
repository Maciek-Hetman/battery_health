import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String text;

  // const CustomCard(this._text, {super.key});
  const CustomCard({Key? key, required String this.text}) : super(key: key);

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
          text,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
      )),
    );
  }
}
