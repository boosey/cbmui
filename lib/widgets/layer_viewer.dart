import 'package:cbmui/widgets/create_object_button.dart';
import 'package:cbmui/widgets/deletable.dart';
import 'package:cbmui/widgets/label_widget.dart';
import 'package:cbmui/widgets/section_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/component_business_model.dart';
import '../util.dart';

class LayerViewer extends ConsumerWidget {
  const LayerViewer({
    super.key,
    required this.layer,
    required this.model,
  });

  final Layer layer;
  final Model model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var label = Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: LabelWidget(
          label: layer.name,
          fontSize: 28,
          onChanged: (s) async {
            layer.name = s;
            await ModelApi.saveModel(
              model: model,
            );
          },
        ),
      ),
    );

    return Deletable(
      onDeleteRequested: () async {
        model.layers!.removeWhere((l) => layer.id == l.id);
        await ModelApi.saveModel(
          model: model,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            label,
            sections(),
          ],
        ),
      ),
    );
  }

  Expanded sections() {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 2, 5, 0),
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 8,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ...layer.sections!
                .map(
                  (s) => SectionViewer(
                    model: model,
                    section: s,
                    layer: layer,
                    displayLabel: layer.sections!.length > 1,
                  ),
                )
                .toList(),
            CreateButton(
              topSpacerPointSize: layer.sections!.length > 1 ? 24 : 0,
              onChanged: () async {
                await ModelApi.createSection(model: model, layer: layer);
                return;
              },
            ),
          ],
        ),
      ),
    );
  }
}
