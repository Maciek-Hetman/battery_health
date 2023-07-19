import 'package:flutter/material.dart';

import '../widgets/card_widget.dart';

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
            const SliverAppBar(
              expandedHeight: 150,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "Battery health",
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 32,
                      fontWeight: FontWeight.w400),
                ),
                titlePadding: EdgeInsetsDirectional.only(start: 24, bottom: 30),
              ),
            ),
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
