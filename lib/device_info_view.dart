import 'package:flutter/material.dart';
import 'package:system_info2/system_info2.dart';

import './card_widget.dart';

class DeviceInfoView extends StatelessWidget {
  final _deviceName;
  final _deviceAndroidVersion;
  final _deviceManufacturer;
  final _deviceBoard;
  final _deviceBrand;
  final _rootAccess;

  final _kernelArch = SysInfo.kernelArchitecture;
  final _kernelBitness = SysInfo.kernelBitness;
  final _kernelVersion = SysInfo.kernelVersion;
  final _cores = SysInfo.cores;
  final _totalMemory = SysInfo.getTotalPhysicalMemory();

  DeviceInfoView(
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
            CustomCard("Root access: ${_rootAccess ? "Yes" : "No"}"),
            CustomCard("Board: $_deviceBoard"),
            CustomCard(
                "Total RAM: ${num.parse((_totalMemory / 1000 / 1000 / 1000).toStringAsFixed(2))} GB"),
            CustomCard("Kernel architecture: $_kernelArch"),
            CustomCard("Kernel bitness: $_kernelBitness bit"),
            CustomCard("Kernel version: $_kernelVersion"),
            CustomCard("Amount of cores: ${_cores.length}"),
          ]),
        )
      ],
    );
    ;
  }
}
