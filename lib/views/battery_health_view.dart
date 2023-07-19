import 'package:flutter/material.dart';

import '../widgets/card_widget.dart';
import '../widgets/app_bar_widget.dart';

class BatteryHealthView extends StatelessWidget {
  final String _batteryHealth;
  final String _cycleCount;
  final String _fullChargeReadable;
  final String _designCapacityReadable;
  final String _batteryLevel;
  final String _batteryState;

  final _controller = ScrollController();

  BatteryHealthView(
      this._batteryHealth,
      this._cycleCount,
      this._fullChargeReadable,
      this._designCapacityReadable,
      this._batteryLevel,
      this._batteryState,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryScrollController(
        controller: _controller,
        child: Scrollbar(
            child: CustomScrollView(
          slivers: <Widget>[
            const ScrollingAppBar("Battery health"),
            SliverList(
              delegate: SliverChildListDelegate([
                CustomCard("Battery level: $_batteryLevel%"),
                CustomCard("Battery state: $_batteryState"),
                CustomCard("Battery health $_batteryHealth%"),
                CustomCard("Cycle count: $_cycleCount"),
                CustomCard("Full charge: $_fullChargeReadable"),
                CustomCard("Design capacity: $_designCapacityReadable"),
              ]),
            )
          ],
        )));
  }
}
