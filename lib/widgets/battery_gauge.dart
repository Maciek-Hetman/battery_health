import 'package:flutter/material.dart';
import 'package:animated_battery_gauge/animated_battery_gauge.dart';
import 'package:animated_battery_gauge/battery_gauge.dart';

class CustomBatteryGauge extends StatelessWidget {
  final int batteryLevel;

  const CustomBatteryGauge({Key? key, required this.batteryLevel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: Center(
        child: AnimatedBatteryGauge(
          duration: const Duration(seconds: 2),
          value: batteryLevel.toDouble(),
          size: const Size(220, 110),
          borderColor: Colors.grey.shade700,
          valueColor: Colors.green,
          mode: BatteryGaugePaintMode.grid,
          hasText: true,
          textStyle: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
