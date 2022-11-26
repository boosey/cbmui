import 'package:cbmui/providers/mode_provider.dart';
import 'package:cbmui/providers/model_viewer_settings.dart';
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
    final settings = ref.watch(modelViewerSettingsProvider);
    final isEditMode = ref.watch(isModelViewerEditModeProvider);

    var label = ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: settings.layerLabelAreaWidth,
        maxWidth: settings.layerLabelAreaWidth,
      ),
      child: LabelWidget(
        label: layer.name,
        fontSize: settings.layerLabelFontSize,
        maxlines: settings.layerLabelMaxLines,
        onChanged: (s) async {
          layer.name = s;
          await ModelApi.saveModel(
            model: model,
          );
        },
      ),
    );

    return DeletableOrMoveable(
      onDeleteRequested: () async {
        model.layers!.removeWhere((l) => layer.id == l.id);
        await ModelApi.saveModel(
          model: model,
        );
      },
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
            ConstrainedBox(
              // constraints: BoxConstraints(maxWidth: allSectionsMaxWidth),
              constraints: BoxConstraints(
                maxWidth: longestSectionRun(
                      model,
                      settings,
                      isEditMode,
                    ) +
                    1,
              ),
              child: Column(
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
            ),
          ],
        ),
      ),
    );
  }

  Widget sections(Layer layer, ModelViewSettings settings, bool isEditMode) {
    final columnCounts = calculateSectionColumnCounts(layer, settings);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: layer.sections!.map(
        (s) {
          final sectionWidth = calculateAdjustedSectionWidth(
            model,
            s,
            columnCounts[s.id]!,
            settings,
            isEditMode,
          );

          return ConstrainedBox(
            constraints:
                BoxConstraints(minWidth: sectionWidth, maxWidth: sectionWidth),
            child: Row(
              children: [
                Expanded(
                  child: SectionViewer(
                    model: model,
                    section: s,
                    layer: layer,
                    columnCount: columnCounts[s.id]!,
                    displayLabel: layer.sections!.length > 1,
                    width: sectionWidth,
                  ),
                ),
              ],
            ),
          );
        },
      ).toList(),
    );
  }
}
