import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_data/flutter_data.dart';

import '../models/component_business_model.dart';

part 'model_viewer_settings.g.dart';

@CopyWith()
class ModelViewSettings {
  final Ref ref;
  final double componentLabelPadding;
  final double componentLabelWidth;
  final double componentBorderWidth;
  final Color componentIsRatedBorderColor;
  final Color componentDefaultBorderColor;
  final Color componentColor;
  final Color componentIsRatedColor;
  final double componentLabelFontSize;
  final FontWeight componentLabelFontWeight;
  final int componentLabelMaxLines;
  final double componentDropIndicatorWidth;
  final double sectionBorderWidth;
  final double sectionLabelFontSize;
  final FontWeight sectionLabelFontWeight;
  final int sectionLabelMaxLines;
  final Color sectionBorderColor;
  final Color sectionColor;
  final double layerLabelWidth;
  final double layerSpacerWidth;
  final double layerLabelFontSize;
  final FontWeight layerLabelFontWeight;
  final int layerLabelMaxLines;
  final double layerPaddingWidth;
  final int layerMaxTotalColumns;
  final int sectionMinColumns;
  final double modelViewerPaddingWidth;
  final double elevation;

  ModelViewSettings({
    required this.ref,
    this.layerMaxTotalColumns = 15,
    this.sectionMinColumns = 2,
    this.componentLabelWidth = 100,
    this.componentLabelPadding = 2,
    this.componentBorderWidth = 2,
    this.componentDropIndicatorWidth = 8,
    this.componentIsRatedBorderColor = Colors.transparent,
    this.componentDefaultBorderColor = Colors.transparent,
    this.componentColor = Colors.white,
    this.componentIsRatedColor = Colors.lightBlueAccent,
    this.componentLabelFontSize = 14,
    this.componentLabelFontWeight = FontWeight.normal,
    this.componentLabelMaxLines = 3,
    this.sectionBorderWidth = 1,
    this.sectionLabelFontSize = 20,
    this.sectionLabelFontWeight = FontWeight.bold,
    this.sectionLabelMaxLines = 1,
    this.sectionBorderColor = Colors.black,
    this.sectionColor = Colors.white,
    this.layerLabelWidth = 250,
    this.layerSpacerWidth = 20,
    this.layerLabelFontSize = 32,
    this.layerPaddingWidth = 5,
    this.layerLabelFontWeight = FontWeight.bold,
    this.layerLabelMaxLines = 3,
    this.modelViewerPaddingWidth = 30,
    this.elevation = 3,
  });

  double get componentBaseSideLength => componentLabelWidth + 20;

  double get componentTotalSideLength {
    final w = componentBaseSideLength + (2 * componentDropIndicatorWidth);

    return w;
  }

  double layerTotalLabelAreaWidth() => layerLabelWidth + layerSpacerWidth;

  double _calculateRawSectionWidth(Section section, int columnCount) {
    final w = ((componentTotalSideLength) * columnCount) +
        ((sectionBorderWidth) * 2) +
        (componentDropIndicatorWidth * 2);

    return w;
  }

  double calculateBaseSectionWidth(
          double totalSectionWidth, ModelViewSettings settings) =>
      totalSectionWidth -
      (settings.componentDropIndicatorWidth * 2) -
      ((settings.sectionBorderWidth) * 2) +
      16;

  double calculateAdjustedSectionWidth(
    Model model,
    Section section,
    int columnCount,
    int columnDiff,
    ModelViewSettings settings,
  ) {
    final maxW = maxWidthOfSectionAreaOfAllLayersInModel(model);

    final percent = (columnCount / settings.layerMaxTotalColumns);

    final percentAdjusted = maxW * percent;
    // final dropAdusted = percentAdjusted +
    //     (columnDiff > 0 ? settings.componentDropIndicatorWidth : 0);

    // log("collDiff: $columnDiff rawW:${_calculateRawSectionWidth(section, columnCount, settings, isEditMode)} percentAdj: $percentAdjusted dropAdjusted: $dropAdusted");

    // log("percentAdj: $percentAdjusted  maxAdjWidth: $maxWDropAdjusted percentAdjustment: $percent");

    return percentAdjusted.ceilToDouble();
  }

  double maxWidthOfSectionAreaOfAllLayersInModel(
    Model model,
  ) {
    final maxW = model.layers!.map(
      (l) {
        final cc = calculateSectionColumnCountsForLayer(l);

        return l.sections!.fold(
          0.0,
          (w, s) {
            return w += _calculateRawSectionWidth(
              s,
              cc[s.id]!,
            );
          },
        );
      },
    ).fold(0.0, (max, x) => x > max ? x : max);

    return (maxW).ceilToDouble();
  }

  // double getTotalWidth(model, isEditMode) =>
  //     maxWidthOfSectionAreaOfAllLayersInModel(model) +
  //     layerTotalLabelAreaWidth();

  Map<String, int> calculateSectionColumnCountsForLayer(Layer layer) {
    final sections = layer.sections!;
    final columnCounts = <String, int>{};

    int columnsRemaining =
        layerMaxTotalColumns - sections.length * sectionMinColumns;

    for (var s in sections) {
      columnCounts.putIfAbsent(s.id, () => sectionMinColumns);
    }

    while (columnsRemaining > 0) {
      final maxDepth = sections.fold(
          0,
          (max, s) => depth(s, columnCounts[s.id]!) > max
              ? depth(s, columnCounts[s.id]!)
              : max);

      final sectionsAtMaxDepth =
          sections.where((s) => depth(s, columnCounts[s.id]!) == maxDepth);

      for (var s in sectionsAtMaxDepth) {
        if (columnsRemaining > 0) {
          columnCounts.update(s.id, (x) => columnCounts[s.id]! + 1);
          columnsRemaining--;
        }
      }
    }

    return columnCounts;
  }

  int depth(Section s, int columnCount) {
    return (s.components!.length / columnCount).ceil();
  }
}

class ModelViewerSettingsNotifier extends StateNotifier<ModelViewSettings> {
  ModelViewerSettingsNotifier(super.state);

  void updateSettings(ModelViewSettings settings) => state = settings;
}

final modelViewerSettingsProvider =
    StateNotifierProvider<ModelViewerSettingsNotifier, ModelViewSettings>(
        (ref) => ModelViewerSettingsNotifier(ModelViewSettings(ref: ref)));
