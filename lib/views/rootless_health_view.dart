import 'package:battery_health/widgets/app_bar_widget.dart';
import 'package:battery_health/widgets/battery_gauge.dart';
import 'package:flutter/material.dart';

import '../widgets/card_widget.dart';

class RootlessHealthView extends StatefulWidget {
  final bool rootAccess;
  final String batteryHealth;
  final String batteryTemperature;
  final int batteryLevel;

  const RootlessHealthView(
      {Key? key,
      required this.rootAccess,
      required this.batteryHealth,
      required this.batteryTemperature,
      required this.batteryLevel})
      : super(key: key);

  @override
  RootlessHealthViewState createState() => RootlessHealthViewState();
}

class RootlessHealthViewState extends State<RootlessHealthView> {
  final String _message =
      "You probably don't have rooted device or have denied root access in magisk. This app requires root access for full functionality.";

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        const ScrollingAppBar(title: "Battery Health"),
        SliverList(
          delegate: SliverChildListDelegate([
            CustomBatteryGauge(batteryLevel: widget.batteryLevel),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child:
                    const Text('Battery info', style: TextStyle(fontSize: 30))),
            CustomCard(text: "Battery health: ${widget.batteryHealth}"),
            CustomCard(
                text: "Battery temperature: ${widget.batteryTemperature}°C"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(_message,
                  style: const TextStyle(
                      fontSize: 20, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.justify),
            )
          ]),
        )
      ],
    );
  }
}
