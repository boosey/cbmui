import 'dart:developer';

import 'package:cbmui/models/component_business_model.dart';
import 'package:flutter/material.dart';

import '../util.dart';

class StrategicWidget extends StatelessWidget {
  const StrategicWidget(
      {Key? key, required this.componentId, required this.model})
      : super(key: key);

  final Model model;
  final String componentId;

  Component findComponent(String cid) {
    late Component c;
    for (var l in model.layers!) {
      for (var s in l.sections!) {
        c = s.components!.firstWhere((t) => t.id == cid);
      }
    }
    return c;
  }

  @override
  Widget build(BuildContext context) {
    final Component component = findComponent(componentId);

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
            // if (component.relationship > 0) {
            await ModelApi.saveModel(model: model);
            // }
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
