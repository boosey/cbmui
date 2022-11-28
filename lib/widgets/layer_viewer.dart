import 'dart:developer' as dev;
import 'dart:math';

import 'package:cbmui/providers/mode_provider.dart';
import 'package:cbmui/providers/model_viewer_settings.dart';
import 'package:cbmui/widgets/create_object_button.dart';
import 'package:cbmui/widgets/deletable.dart';
import 'package:cbmui/widgets/label_widget.dart';
import 'package:cbmui/widgets/section_viewer.dart';
import 'package:cbmui/widgets/vertical_drop_zone.dart';
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
    final settings = ref.watch(modelViewerSettingsProvider);
    final isEditMode = ref.watch(isModelViewerEditModeProvider);

    var label = LabelWidget(
      label: layer.name,
      width: settings.layerLabelWidth,
      fontSize: settings.layerLabelFontSize,
      maxlines: settings.layerLabelMaxLines,
      onChanged: (s) async {
        layer.name = s;
        await ModelApi.saveModel(
          model: model,
        );
      },
    );

    return DeletableOrMoveable(
      onDeleteRequested: () async {
        model.layers!.removeWhere((l) => layer.id == l.id);
        await ModelApi.saveModel(
          model: model,
        );
      },
      child: VerticalDoubleDropZone(
        id: layer.id,
        type: "layer",
        model: model,
        onDrop: ((p0, p1, p2) {
          dev.log("before: $p1  after: $p2");
          model.moveLayer(p0, p1, p2);
        }),
        indicatorWidth: settings.componentDropIndicatorWidth,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              0, settings.layerPaddingWidth, 0, settings.layerPaddingWidth),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              label,
              SizedBox(
                width: settings.layerSpacerWidth,
                height: 1,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CreateButton(
                    label: "Section",
                    onChanged: () async {
                      await ModelApi.createSection(model: model, layer: layer);
                      return;
                    },
                  ),
                  sections(layer, settings, isEditMode),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sections(Layer layer, ModelViewSettings settings, bool isEditMode) {
    final columnCounts = settings.calculateSectionColumnCountsForLayer(layer);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: layer.sections!.map(
        (s) {
          final cols = columnCounts[s.id]!;
          final maxCols = columnCounts.values
              .fold(0, (maxC, count) => maxC = max(maxC, count));
          final sectionWidth = settings.calculateAdjustedSectionWidth(
            model,
            s,
            cols,
            maxCols - cols,
            settings,
          );

          return SectionViewer(
            model: model,
            section: s,
            layer: layer,
            columnCount: columnCounts[s.id]!,
            width: sectionWidth,
            displayLabel: layer.sections!.length > 1,
          );
        },
      ).toList(),
    );
  }
}
