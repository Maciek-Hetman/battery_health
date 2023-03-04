import 'package:flutter/material.dart';
import './card_widget.dart';

class DeviceInfoView extends StatelessWidget {
  final _deviceName;
  final _deviceAndroidVersion;
  final _deviceManufacturer;
  final _deviceBoard;
  final _deviceBrand;
  final _rootAccess;

  const DeviceInfoView(
      this._deviceName,
      this._deviceManufacturer,
      this._deviceAndroidVersion,
      this._deviceBoard,
      this._deviceBrand,
      this._rootAccess,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        const SliverAppBar(
          expandedHeight: 150,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              "Device info",
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
            CustomCard("Device: $_deviceName"),
            CustomCard("Brand: $_deviceBrand"),
            CustomCard("Manufacturer: $_deviceManufacturer"),
            CustomCard("Android version: $_deviceAndroidVersion"),
            CustomCard("Root access: $_rootAccess"),
            CustomCard("Board: $_deviceBoard"),
          ]),
        )
      ],
    );
    ;
  }
}
