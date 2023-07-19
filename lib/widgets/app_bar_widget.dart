import 'package:flutter/material.dart';

class ScrollingAppBar extends StatelessWidget {
  const ScrollingAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 150,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          "Device info",
          style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 32,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black),
        ),
        titlePadding: const EdgeInsetsDirectional.only(start: 24, bottom: 30),
      ),
    );
  }
}
