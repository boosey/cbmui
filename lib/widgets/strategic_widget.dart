import 'dart:developer';

import 'package:cbmui/models/component_business_model.dart';
import 'package:flutter/material.dart';

import '../util.dart';

class StrategicWidget extends StatelessWidget {
  const StrategicWidget(
      {Key? key, required this.component, required this.model})
      : super(key: key);

  final Model model;
  final Component component;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            "Strategic Importance",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ToggleButtons(
          onPressed: (index) async {
            log("index: $index");
            component.strategic = index + 1;
            await ModelApi.saveModel(model: model);
          },
          isSelected: [
            component.strategic == 1,
            component.strategic == 2,
            component.strategic == 3,
            component.strategic == 4,
          ],
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("None"),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Neutral"),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Tactical"),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Strategic"),
            ),
          ],
        ),
      ],
    );
  }
}
