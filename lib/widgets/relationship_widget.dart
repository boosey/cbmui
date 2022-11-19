import 'package:cbmui/models/component_business_model.dart';
import 'package:flutter/material.dart';

import '../util.dart';

class RelationshipWidget extends StatelessWidget {
  const RelationshipWidget(
      {Key? key, required this.component, required this.model})
      : super(key: key);

  final Model model;
  final Component component;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            "Relationship Strength",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ToggleButtons(
          onPressed: (index) async {
            component.relationship = index + 1;
            await ModelApi.saveModel(model: model);
          },
          isSelected: [
            component.relationship == 1,
            component.relationship == 2,
            component.relationship == 3,
            component.relationship == 4,
          ],
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Negative"),
            ),
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
              child: Text("Promoter"),
            ),
          ],
        ),
      ],
    );
  }
}
