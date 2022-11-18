import 'package:cbmui/providers/mode_provider.dart';
import 'package:cbmui/widgets/label_widget.dart';
import 'package:cbmui/widgets/section_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/component_business_model.dart';
import '../util.dart';

class LayerViewer extends ConsumerWidget {
  const LayerViewer._({
    super.key,
    this.layer,
    required this.model,
    this.createLayerWidget = false,
  });

  final Layer? layer;
  final Model model;
  final bool createLayerWidget;

  factory LayerViewer.layerCreateButton({required Model model}) {
    return LayerViewer._(
      key: ValueKey('createlayer${model.id}'),
      model: model,
      createLayerWidget: true,
    );
  }

  factory LayerViewer.layerContentWidget(
      {required Model model, required Layer layer}) {
    return LayerViewer._(
      key: ValueKey("layerviewer${layer.id}"),
      model: model,
      layer: layer,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget labelWidget;
    Widget content;

    final isEditMode = ref.watch(isEditModeProvider);

    if (createLayerWidget) {
      labelWidget = const LabelWidget(
        label: "",
        readonly: true,
      );

      content = ElevatedButton(
        onPressed: () async {
          await ModelApi.createLayer(model: model);
          return;
        },
        style: createButtonStyle.copyWith(
            maximumSize:
                const MaterialStatePropertyAll(Size(double.infinity, 40))),
        child: const Icon(Icons.add_box),
      );
    } else {
      labelWidget = LabelWidget(
        label: layer!.name,
        fontSize: 28,
        onChanged: (s) async {
          layer!.name = s;
          await ModelApi.saveModel(
            model: model,
          );
        },
      );

      content = Wrap(
        direction: Axis.horizontal,
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          ...layer!.sections!
              .map(
                (s) => SectionViewer.contentWidget(
                  model: model,
                  section: s,
                  layer: layer!,
                  displayLabel: layer!.sections!.length > 1,
                ),
              )
              .toList(),
          Visibility(
            visible: isEditMode,
            child: SectionViewer.createButton(
              model: model,
              layer: layer!,
              shiftDownForLabel: layer!.sections!.length > 1,
            ),
          ),
        ],
      );
    }

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: labelWidget,
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 2, 5, 0),
                  child: content,
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: isEditMode && !createLayerWidget,
          child: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () async {
              model.layers!.removeWhere((l) => layer!.id == l.id);
              await ModelApi.saveModel(
                model: model,
              );
            },
          ),
        ),
      ],
    );
  }
}
