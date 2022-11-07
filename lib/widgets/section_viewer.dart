import 'package:flutter/material.dart';

import '../models/component_business_model.dart';
import 'component_viewer.dart';

class SectionViewer extends StatelessWidget {
  const SectionViewer(
      {super.key, required this.section, this.displayName = true});

  final Section section;
  final bool displayName;

  @override
  Widget build(BuildContext context) {
    final componentsWidgets = section.components!
        .map(
          (c) => Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: ComponentViewer(component: c),
          ),
        )
        .toList();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Visibility(
          visible: displayName,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Text(
              section.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Visibility(
          visible: displayName,
          child: Card(
            child: Wrap(
              children: componentsWidgets,
            ),
          ),
        ),
        Visibility(
          visible: !displayName,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: componentsWidgets,
            ),
          ),
        ),
      ],
    );
  }
}
