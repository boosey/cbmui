import 'package:cbmui/widgets/section_viewer.dart';
import 'package:flutter/material.dart';

import '../models/component_business_model.dart';

class LayerViewer extends StatelessWidget {
  const LayerViewer({super.key, required this.layer});

  final Layer layer;

  @override
  Widget build(BuildContext context) {
    int sectionCount = layer.sections!.length;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Expanded(
            flex: 1,
            child: Text(
              layer.name,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 2, 5, 0),
              child: Row(
                  children: layer.sections!
                      .map((s) => SectionViewer(
                          section: s, displayName: sectionCount >= 1))
                      .toList()),
            ),
          ),
        ),
      ],
    );
  }
}
