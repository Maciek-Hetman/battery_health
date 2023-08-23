import 'package:animated_battery_gauge/animated_battery_gauge.dart';
import 'package:animated_battery_gauge/battery_gauge.dart';
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
  _RootlessHealthViewState createState() => _RootlessHealthViewState();
}

class _RootlessHealthViewState extends State<RootlessHealthView> {
  final String _message =
      "You probably don't have rooted device or have denied root access in magisk. This app requires root access for full functionality.";

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        const SliverAppBar(
          expandedHeight: 150,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              "Battery health",
              style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 34,
                  fontWeight: FontWeight.w400),
            ),
            titlePadding: EdgeInsetsDirectional.only(start: 24, bottom: 30),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 22),
              child: Center(
                child: AnimatedBatteryGauge(
                  duration: const Duration(seconds: 2),
                  value: widget.batteryLevel.toDouble(),
                  size: const Size(220, 110),
                  borderColor: Colors.grey.shade700,
                  valueColor: Colors.green,
                  mode: BatteryGaugePaintMode.grid,
                  hasText: true,
                  textStyle: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child:
                    const Text('Battery info', style: TextStyle(fontSize: 30))),
            CustomCard("Battery health: ${widget.batteryHealth}"),
            CustomCard("Battery temperature: ${widget.batteryTemperature}°C"),
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
