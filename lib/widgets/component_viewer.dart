import 'package:flutter/material.dart';

import '../models/component_business_model.dart';

class ComponentViewer extends StatelessWidget {
  const ComponentViewer({super.key, required this.component});

  final Component component;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Card(
        elevation: 3,
        child: Text(component.name),
      ),
    );
  }
}
