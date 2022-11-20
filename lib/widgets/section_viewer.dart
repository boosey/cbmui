import 'package:cbmui/providers/mode_provider.dart';
import 'package:cbmui/widgets/create_object_button.dart';
import 'package:cbmui/widgets/label_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/component_business_model.dart';
import '../util.dart';
import 'component_viewer.dart';

class SectionViewer extends ConsumerWidget {
  const SectionViewer({
    super.key,
    required this.section,
    this.displayLabel = false,
    required this.model,
    required this.layer,
  });

  final Section section;
  final bool displayLabel;
  final Model model;
  final Layer layer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Widget mainWidget;

    final isEditMode = ref.watch(isModelViewerEditModeProvider);

    final componentsWidgets = [
      ...section.components!
          .map(
            (c) => Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: ComponentViewer(
                component: c,
                section: section,
                layer: layer,
                model: model,
              ),
            ),
          )
          .toList(),
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: CreateButton(
          onChanged: () async => await ModelApi.createComponent(
            model: model,
            layer: layer,
            section: section,
          ),
        ),
      ),
    ];

    mainWidget = Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: displayLabel,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: LabelWidget(
                  label: section.name,
                  fontSize: 22,
                  width: 200,
                  onChanged: (s) async {
                    section.name = s;
                    await ModelApi.saveModel(
                      model: model,
                    );
                  },
                ),
              ),
            ),
            Container(
              constraints:
                  BoxConstraints.loose(const Size(600, double.infinity)),
              decoration: BoxDecoration(
                  border: Border.all(width: 2.0, color: Colors.black)),
              child: Wrap(
                direction: Axis.horizontal,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 5,
                runSpacing: 5,
                children: componentsWidgets,
              ),
            ),
          ],
        ),
        Visibility(
          visible: isEditMode,
          child: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () async {
              layer.sections!.removeWhere((s) => section.id == s.id);
              await ModelApi.saveModel(
                model: model,
              );
            },
          ),
        ),
      ],
    );

    return mainWidget;
  }
}
