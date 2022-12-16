import 'package:cbmui/models/component_business_model.dart';
import 'package:flutter/material.dart';

import '../api/model_api.dart';

class IBMDivisionSelector extends StatelessWidget {
  const IBMDivisionSelector({
    super.key,
    required this.component,
    required this.model,
  });

  final Component component;
  final Model model;

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      onPressed: (index) async {
        switch (index) {
          case 0:
            component.isIbmConsulting = !component.isIbmConsulting;
            break;
          case 1:
            component.isIbmTechnology = !component.isIbmTechnology;
            break;
        }

        await ModelApi.saveModel(model: model);
      },
      isSelected: [
        component.isIbmConsulting,
        component.isIbmTechnology,
      ],
      children: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Consulting"),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Technology"),
        ),
      ],
    );
  }
}
