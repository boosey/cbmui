import 'package:cbmui/widgets/relationship_widget.dart';
import 'package:cbmui/widgets/strategic_widget.dart';
import 'package:flutter/material.dart';

import '../models/component_business_model.dart';

class ComponentAnalyzer extends StatelessWidget {
  const ComponentAnalyzer(
      {Key? key, required this.model, required this.component})
      : super(key: key);

  final Model model;
  final Component component;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(component.name),
        StrategicWidget(component: component, model: model),
        RelationshipWidget(component: component, model: model),
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.check_circle),
        ),
      ],
    );
  }
}
