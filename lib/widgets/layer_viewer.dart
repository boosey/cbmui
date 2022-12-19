import 'dart:developer' as dev;
import 'dart:math';
import 'package:cbmui/widgets/create_object_button.dart';
import 'package:cbmui/widgets/edit_buttons.dart';
import 'package:cbmui/widgets/label_widget.dart';
import 'package:cbmui/widgets/section_viewer.dart';
import 'package:cbmui/widgets/vertical_drop_zone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/model_info_provider.dart';
import '../api/model_api.dart';

class LayerViewer extends ConsumerWidget {
  const LayerViewer({
    super.key,
    required this.lid,
    required this.mid,
  });

  final String lid;
  final String mid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modelInfo = ref.watch(modelInfoProvider(mid));
    final model = modelInfo.model;
    final layer = model.findLayer(lid);
    final settings = modelInfo.settings;

    var label = LabelWidget(
      label: layer.name,
      width: settings.layerLabelWidth,
      fontSize: settings.layerLabelFontSize,
      maxlines: settings.layerLabelMaxLines,
      onChanged: (s) async {
        layer.name = s;
        await ModelApi.saveCBModel(
          model: model,
        );
      },
    );

    final sections = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: layer.sections.map(
        (s) {
          final columnCounts =
              modelInfo.calculateTotalSectionColumnCountsForLayer(layer);
          final cols = columnCounts[s.id]!;
          final maxCols = columnCounts.values
              .fold(0, (maxC, count) => maxC = max(maxC, count));
          final sectionWidth = settings.calculateAdjustedSectionWidth(
            model,
            s,
            cols,
            maxCols - cols,
          );

          return SectionViewer(
            mid: model.id,
            sid: s.id,
            lid: layer.id,
            columnCount: columnCounts[s.id]!,
            width: sectionWidth,
            displayLabel: layer.sections.length > 1,
          );
        },
      ).toList(),
    );

    return VerticalDoubleDropZone(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EditButtons(onDelete: () async {
              await model.deleteLayer(lid);
            }),
            Row(
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
                        await ModelApi.createSection(
                            model: model, layer: layer);
                        return;
                      },
                    ),
                    sections,
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
