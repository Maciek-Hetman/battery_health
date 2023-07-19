import 'package:battery_health/widgets/card_widget.dart';
import 'package:flutter/material.dart';

class NoBatteryInfoView extends StatelessWidget {
  final bool _rootAccess;
  final String _message =
      "If you see this screen, you probably don't have root access or have denied access in magisk. This function requires rooted device, without it this function won't work.";

  const NoBatteryInfoView(this._rootAccess, {super.key});

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
            const CustomCard("Could not fetch battery info"),
            CustomCard("Root status: $_rootAccess"),
            Padding(
              padding: const EdgeInsets.all(8),
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
