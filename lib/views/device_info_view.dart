import 'package:flutter/material.dart';
import 'package:system_info2/system_info2.dart';

import '../widgets/card_widget.dart';
import '../widgets/app_bar_widget.dart';

class DeviceInfoView extends StatelessWidget {
  final String _deviceName;
  final String _deviceAndroidVersion;
  final String _deviceManufacturer;
  final String _deviceBoard;
  final String _deviceBrand;
  final bool _rootAccess;

  final _kernelArch = SysInfo.kernelArchitecture;
  final _kernelBitness = SysInfo.kernelBitness;
  final _kernelVersion = SysInfo.kernelVersion;
  final _cores = SysInfo.cores;
  final _totalMemory = SysInfo.getTotalPhysicalMemory();

  final _controller = ScrollController();

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
    return PrimaryScrollController(
        controller: _controller,
        child: Scrollbar(
            interactive: false,
            radius: const Radius.circular(4),
            child: CustomScrollView(
              slivers: <Widget>[
                const ScrollingAppBar(),
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
                    CustomCard("Core count: ${_cores.length}"),
                  ]),
                )
              ],
            )));
  }
}
