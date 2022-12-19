import 'package:flutter/material.dart';

import '../api/model_api.dart';
import '../models/cbmodel.dart';
import '../models/component.dart';

class StrategicWidget extends StatelessWidget {
  const StrategicWidget(
      {Key? key, required this.componentId, required this.model})
      : super(key: key);

  final CBModel model;
  final String componentId;

  @override
  Widget build(BuildContext context) {
    final Component component = model.findComponent(componentId, model);

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
            component.strategic = index + 1;
            // if (component.relationship > 0) {
            await ModelApi.saveCBModel(model: model);
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
