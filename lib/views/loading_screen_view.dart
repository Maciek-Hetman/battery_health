import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Padding(
      padding: EdgeInsets.all(150),
      child: LoadingIndicator(
        indicatorType: Indicator.ballRotateChase,
        colors: [Colors.blue],
      ),
    ));
  }
}
