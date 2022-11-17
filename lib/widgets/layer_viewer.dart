import 'package:cbmui/widgets/section_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cbmui/main.data.dart';
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
    Widget rowWidget;

    if (createLayerWidget) {
      labelWidget = const Text(
        "",
        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      );

      rowWidget = ElevatedButton(
        onPressed: () async {
          await ModelApi.createLayer(repository: ref.models, model: model);
          return;
        },
        style: createButtonStyle.copyWith(
            maximumSize:
                const MaterialStatePropertyAll(Size(double.infinity, 40))),
        child: const Icon(Icons.add_box),
      );
    } else {
      labelWidget = Text(
        layer!.name,
        style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      );

      rowWidget = Wrap(
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
          SectionViewer.createButton(
            model: model,
            layer: layer!,
            shiftDownForLabel: layer!.sections!.length > 1,
          ),
        ],
      );
    }

    return Padding(
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
              child: rowWidget,
            ),
          ),
        ],
      ),
    );
  }
}
