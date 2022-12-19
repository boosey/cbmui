import 'package:flutter/material.dart';

import '../api/model_api.dart';
import '../models/cbmodel.dart';
import '../models/component.dart';

class RelationshipArea extends StatelessWidget {
  const RelationshipArea({
    super.key,
    required this.component,
    required this.model,
  });

  final Component component;
  final CBModel model;

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      onPressed: (index) async {
        switch (index) {
          case 0:
            component.isBusiness = !component.isBusiness;
            break;
          case 1:
            component.isAppDev = !component.isAppDev;
            break;
          case 2:
            component.isOpsInfra = !component.isOpsInfra;
            break;
        }

        await ModelApi.saveCBModel(model: model);
      },
      isSelected: [
        component.isBusiness,
        component.isAppDev,
        component.isOpsInfra,
      ],
      children: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Business"),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Application Development"),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Operations"),
        ),
      ],
    );
  }
}
