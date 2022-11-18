import 'package:cbmui/providers/mode_provider.dart';
import 'package:cbmui/widgets/label_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cbmui/main.data.dart';
import '../models/component_business_model.dart';
import '../util.dart';
import 'component_viewer.dart';

class SectionViewer extends ConsumerWidget {
  const SectionViewer._(
      {super.key,
      this.section,
      this.displayLabel = false,
      required this.model,
      required this.layer,
      this.createSectionWidget = false});

  final Section? section;
  final bool displayLabel;
  final Model model;
  final Layer layer;
  final bool createSectionWidget;

  factory SectionViewer.createButton({
    required Model model,
    required Layer layer,
    required bool shiftDownForLabel,
  }) {
    return SectionViewer._(
      model: model,
      layer: layer,
      createSectionWidget: true,
      displayLabel: shiftDownForLabel,
    );
  }

  factory SectionViewer.contentWidget(
      {required Model model,
      required Layer layer,
      required Section section,
      required displayLabel}) {
    return SectionViewer._(
      key: ValueKey(section.id),
      model: model,
      layer: layer,
      section: section,
      displayLabel: displayLabel,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Widget mainWidget;

    final isEditMode = ref.watch(isEditModeProvider);

    if (createSectionWidget) {
      mainWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            visible: displayLabel,
            child: const Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: LabelWidget(
                label: "",
                readonly: true,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await ModelApi.createSection(
                  repository: ref.models, model: model, layer: layer);
              return;
            },
            style: createButtonStyle.copyWith(
                fixedSize: const MaterialStatePropertyAll(Size(10, 110))),
            child: const Icon(Icons.add_box),
          ),
        ],
      );
    } else {
      final componentsWidgets = [
        ...section!.components!
            .map(
              (c) => Padding(
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: ComponentViewer.contentWidget(
                  component: c,
                  section: section!,
                  layer: layer,
                  model: model,
                ),
              ),
            )
            .toList(),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Visibility(
            visible: isEditMode,
            child: ComponentViewer.createButton(
              model: model,
              layer: layer,
              section: section!,
            ),
          ),
        ),
      ];

      mainWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            visible: displayLabel,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: LabelWidget(
                label: (section != null) ? section!.name : " ",
                fontSize: 22,
                width: 200,
                onChanged: (s) async {
                  section!.name = s;
                  await ModelApi.saveModel(
                    repository: ref.models,
                    model: model,
                  );
                },
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints.loose(const Size(600, double.infinity)),
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
      );
    }

    return mainWidget;
  }
}
