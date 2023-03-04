import 'package:flutter/material.dart';

import './card_widget.dart';

class BatteryHealthView extends StatelessWidget {
  final String _batteryHealth;
  final String _cycleCount;
  final String _fullChargeReadable;
  final String _designCapacityReadable;
  final String _deviceName;
  final String _deviceManufacturer;
  final String _deviceAndroidVersion;
  final bool _rootAccess;

  final _controller = ScrollController();

  BatteryHealthView(
      this._batteryHealth,
      this._cycleCount,
      this._fullChargeReadable,
      this._designCapacityReadable,
      this._deviceName,
      this._deviceManufacturer,
      this._deviceAndroidVersion,
      this._rootAccess,
      {super.key});

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
