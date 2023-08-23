import 'package:flutter/material.dart';
import 'package:system_info2/system_info2.dart';

import '../widgets/card_widget.dart';
import '../widgets/app_bar_widget.dart';

class DeviceInfoView extends StatelessWidget {
  final String deviceName;
  final String deviceAndroidVersion;
  final String deviceManufacturer;
  final String deviceBoard;
  final String deviceBrand;
  final bool rootAccess;

  final _kernelArch = SysInfo.kernelArchitecture;
  final _kernelBitness = SysInfo.kernelBitness;
  final _kernelVersion = SysInfo.kernelVersion;
  final _cores = SysInfo.cores;
  final _totalMemory = SysInfo.getTotalPhysicalMemory();

  final _controller = ScrollController();

  DeviceInfoView({
    Key? key,
    required this.deviceName,
    required this.deviceAndroidVersion,
    required this.deviceManufacturer,
    required this.deviceBoard,
    required this.deviceBrand,
    required this.rootAccess,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryScrollController(
        controller: _controller,
        child: Scrollbar(
            interactive: false,
            radius: const Radius.circular(4),
            child: CustomScrollView(
              slivers: <Widget>[
                const ScrollingAppBar(title: "Device info"),
                SliverList(
                  delegate: SliverChildListDelegate([
                    CustomCard(text: "Device: $deviceName"),
                    CustomCard(text: "Brand: $deviceBrand"),
                    CustomCard(text: "Manufacturer: $deviceManufacturer"),
                    CustomCard(text: "Android version: $deviceAndroidVersion"),
                    CustomCard(
                        text: "Root access: ${rootAccess ? "Yes" : "No"}"),
                    CustomCard(text: "Board: $deviceBoard"),
                    CustomCard(
                        text:
                            "Total RAM: ${num.parse((_totalMemory / 1000 / 1000 / 1000).toStringAsFixed(2))} GB"),
                    CustomCard(text: "Kernel architecture: $_kernelArch"),
                    CustomCard(text: "Kernel bitness: $_kernelBitness bit"),
                    CustomCard(text: "Kernel version: $_kernelVersion"),
                    CustomCard(text: "Core count: ${_cores.length}"),
                  ]),
                )
              ],
            )));
  }
}
