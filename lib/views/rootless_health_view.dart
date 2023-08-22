import 'package:flutter/material.dart';

import '../widgets/card_widget.dart';

class RootlessHealthView extends StatefulWidget {
  final bool rootAccess;
  final String batteryHealth;
  final String batteryTemperature;

  const RootlessHealthView(
      {Key? key,
      required this.rootAccess,
      required this.batteryHealth,
      required this.batteryTemperature})
      : super(key: key);

  @override
  _RootlessHealthViewState createState() => _RootlessHealthViewState();
}

class _RootlessHealthViewState extends State<RootlessHealthView> {
  final String _message =
      "If you see this message, you probably don't have root access or have denied access in magisk. This applicatoin requires root access for full functionality.";

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
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child:
                    const Text('Battery info', style: TextStyle(fontSize: 30))),
            CustomCard("Root status: ${widget.rootAccess.toString()}"),
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
