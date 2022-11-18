import 'dart:developer' as dev;
import 'dart:math';

import 'package:cbmui/models/component_business_model.dart';
import 'package:cbmui/providers/mode_provider.dart';
import 'package:cbmui/widgets/label_widget.dart';
import 'package:cbmui/widgets/layer_viewer.dart';
import 'package:cbmui/widgets/mode_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cbmui/main.data.dart';
import '../util.dart';

class ModelViewer extends ConsumerWidget {
  const ModelViewer({super.key, required this.model});

  final Model model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final mode = ref.watch(modeProvider);
    final isEditMode = ref.watch(isEditModeProvider);
    int index = 1;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: LabelWidget(
                label: model.name,
                onChanged: (s) async {
                  model.name = s;
                  await ModelApi.saveModel(
                    repository: ref.models,
                    model: model,
                  );
                },
              ),
            ),
            const ModeSelector(),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 500,
                maxWidth: 2000,
                maxHeight: 10000,
              ),
              child: ReorderableListView(
                buildDefaultDragHandles: false,
                onReorder: (int oldIndex, int newIndex) async {
                  // final oi = oldIndex < newIndex ? oldIndex - 1 : oldIndex;
                  final ni = oldIndex < newIndex ? newIndex - 1 : newIndex - 1;
                  final oi = oldIndex - 1;
                  // final ni = newIndex - 2;
                  dev.log("oldIndex: $oldIndex adjusted: $oi");
                  dev.log("newIndex: $newIndex adjusted: $ni");
                  dev.log("-------------------------");

                  final l = model.layers!.removeAt(oldIndex - 1);

                  if (oldIndex < newIndex) {
                    // Moving down adjust for create button and removed item
                    model.layers!.insert(max(1, newIndex - 2), l);
                  } else {
                    // Moving up adjust for create button
                    model.layers!
                        .insert(min(newIndex - 1, model.layers!.length - 1), l);
                  }

                  model.layers!.insert(ni, l);
                  await ModelApi.saveModel(
                    repository: ref.models,
                    model: model,
                  );
                },
                children: [
                  Visibility(
                    key: ValueKey("layercreatevisibility${model.id}"),
                    visible: isEditMode,
                    child: LayerViewer.layerCreateButton(model: model),
                  ),
                  ...model.layers!.map(
                    (l) {
                      return listRow(l, index);
                    },
                  ).toList(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget listRow(Layer l, int index) {
    return LayerViewer.layerContentWidget(
      layer: l,
      model: model,
    );
  }

  Widget listRow2(Layer l, int index) {
    return Row(
      key: ValueKey('rodslrow${l.id}'),
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.drag_handle,
          size: 24,
        ),
        Flexible(
          key: ValueKey('rodslflex${l.id}'),
          fit: FlexFit.loose,
          child: ReorderableDragStartListener(
            key: ValueKey('rodsl${l.id}'),
            index: index++,
            child: LayerViewer.layerContentWidget(
              layer: l,
              model: model,
            ),
          ),
        ),
      ],
    );
  }
}