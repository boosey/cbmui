import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/cbmodel.dart';
import '../models/layer.dart';
import '../models/section.dart';

part 'view_settings.freezed.dart';
part 'view_settings.g.dart';

@freezed
class ViewSettings with _$ViewSettings {
  const ViewSettings._();

  factory ViewSettings({
    @Default(false) bool showSettingsView,
    @Default(350) double subquadrantMinWidth,
    @Default(350) double subquadrantMinHeight,
    @Default(500) double subquadrantMaxWidth,
    @Default(500) double subquadrantMaxHeight,
    @Default(6) double subquadrantThickBorderWidth,
    @Default(1) double subquadrantThinBorderWidth,
    @Default(24) double analyzeSubtitleFontSize,
    @Default(15) int layerMaxTotalColumns,
    @Default(2) int sectionMinColumns,
    @Default(100) double componentLabelWidth,
    @Default(8) double componentDropIndicatorWidth,
    @Default(Colors.white) Color componentColor,
    @Default(Colors.lightBlueAccent) Color componentIsRatedColor,
    @Default(14) double componentLabelFontSize,
    @Default(FontWeight.normal) FontWeight componentLabelFontWeight,
    @Default(3) int componentLabelMaxLines,
    @Default(1) double sectionBorderWidth,
    @Default(20) double sectionLabelFontSize,
    @Default(FontWeight.bold) FontWeight sectionLabelFontWeight,
    @Default(1) int sectionLabelMaxLines,
    @Default(Colors.black) Color sectionBorderColor,
    @Default(Colors.white) Color sectionColor,
    @Default(250) double layerLabelWidth,
    @Default(20) double layerSpacerWidth,
    @Default(32) double layerLabelFontSize,
    @Default(5) double layerPaddingWidth,
    @Default(FontWeight.bold) FontWeight layerLabelFontWeight,
    @Default(3) int layerLabelMaxLines,
    @Default(30) double modelViewerPaddingWidth,
    @Default(2) double elevation,
  }) = _ViewSettings;

  factory ViewSettings.fromJson(Map<String, dynamic> json) =>
      _$ViewSettingsFromJson(json);

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
          double totalSectionWidth, ViewSettings settings) =>
      totalSectionWidth -
      (settings.componentDropIndicatorWidth * 2) -
      ((settings.sectionBorderWidth) * 2) +
      16;

  double calculateAdjustedSectionWidth(
    CBModel model,
    Section section,
    int columnCount,
    int columnDiff,
  ) {
    final maxW = maxWidthOfSectionAreaOfAllLayersInModel(model);
    final percent = (columnCount / layerMaxTotalColumns);
    final percentAdjusted = maxW * percent;
    return percentAdjusted.ceilToDouble();
  }

  double maxWidthOfSectionAreaOfAllLayersInModel(
    CBModel model,
  ) {
    final maxW = model.layers.map(
      (l) {
        final cc = calculateSectionColumnCountsForLayer(l);

        return l.sections.fold(
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

  Map<String, int> calculateSectionColumnCountsForLayer(Layer layer) {
    final sections = layer.sections;
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
    return (s.components.length / columnCount).ceil();
  }
}

class ModelViewerSettingsNotifier extends StateNotifier<ViewSettings> {
  ModelViewerSettingsNotifier(super.state);

  void updateSettings(ViewSettings settings) => state = settings;
  void showSettingsView() => state = state.copyWith(showSettingsView: true);
  void hideSettingsView() => state = state.copyWith(showSettingsView: false);
}

final viewSettingsProvider =
    StateNotifierProvider<ModelViewerSettingsNotifier, ViewSettings>(
        (ref) => ModelViewerSettingsNotifier(ViewSettings()));
