import 'dart:math';

import 'package:cbmui/providers/model_provider.dart';
import 'package:cbmui/providers/model_viewer_settings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/component_business_model.dart';

class ModelInfo {
  final Model model;
  final ModelViewSettings settings;
  final Map<String, Map<String, int>> layersSectionColumnCounts = {};
  final Map<String, Map<String, double>> rawSectionWidths = {};
  final Map<String, Map<String, double>> adjustedSectionWidths = {};
  final Map<String, Map<String, int>> sectionDepths = {};
  late double maxSectionContentWidth = 0;

  ModelInfo({
    required this.model,
    required this.settings,
  }) {
    // Column Counts
    for (var l in model.layers!) {
      layersSectionColumnCounts.putIfAbsent(
          l.id, () => calculateTotalSectionColumnCountsForLayer(l));
    }

    // Length of Longest Section Content
    maxSectionContentWidth = maxWidthOfSectionAreaOfAllLayersInModel();

    // Raw Section Widths
    calculateSectionInfoByLayer<double>(
        rawSectionWidths, (l, s) => _calculateRawSectionWidth(l, s));

    //Section Depths
    calculateSectionInfoByLayer<int>(sectionDepths, (l, s) => depth(l, s));

    // Addjusted Sections Widths
    calculateSectionInfoByLayer<double>(
        adjustedSectionWidths, (l, s) => calculateAdjustedSectionWidth(l, s));
  }

  void calculateSectionInfoByLayer<T>(Map<String, Map<String, T>> repo,
      dynamic Function(Layer, Section) calculator) {
    for (var l in model.layers!) {
      var insideMap = <String, T>{};
      repo.putIfAbsent(l.id, () => insideMap);
      for (var s in l.sections!) {
        insideMap.putIfAbsent(s.id, () => calculator.call(l, s));
      }
    }
  }

// done
  double _calculateRawSectionWidth(Layer l, Section s) {
    assert(layersSectionColumnCounts.isNotEmpty);

    final w = ((settings.componentTotalSideLength) *
            layersSectionColumnCounts[l.id]![s.id]!) +
        ((settings.sectionBorderWidth) * 2) +
        (settings.componentDropIndicatorWidth * 2);

    return w;
  }

  double calculateBaseSectionWidth(double totalSectionWidth) =>
      totalSectionWidth -
      (settings.componentDropIndicatorWidth * 2) -
      ((settings.sectionBorderWidth) * 2) +
      16;

//done
  double calculateAdjustedSectionWidth(Layer l, Section s) {
    assert(layersSectionColumnCounts.isNotEmpty);
    assert(maxSectionContentWidth > 0);

    final percent = (layersSectionColumnCounts[l.id]![s.id]! /
        settings.layerMaxTotalColumns);

    final percentAdjusted = maxSectionContentWidth * percent;

    return percentAdjusted.ceilToDouble();
  }

// done
  double maxWidthOfSectionAreaOfAllLayersInModel() {
    assert(layersSectionColumnCounts.isNotEmpty);

    final maxW = model.layers!.map(
      (l) {
        return l.sections!.fold(
          0.0,
          (w, s) {
            return w += layersSectionColumnCounts[l.id]![s.id]!;
          },
        );
      },
    ).fold(0.0, (curMax, x) => max(curMax, x));

    return (maxW).ceilToDouble();
  }

// done
  Map<String, int> calculateTotalSectionColumnCountsForLayer(Layer l) {
    final sections = l.sections!;
    final columnCounts = <String, int>{};

    int columnsRemaining = settings.layerMaxTotalColumns -
        sections.length * settings.sectionMinColumns;

    for (var s in sections) {
      columnCounts.putIfAbsent(s.id, () => settings.sectionMinColumns);
    }

    while (columnsRemaining > 0) {
      final maxDepth = sections.fold(
          0,
          (curMax, s) =>
              max(curMax, (s.components!.length / columnCounts[s.id]!).ceil()));

      final sectionsAtMaxDepth = sections.where((s) =>
          (s.components!.length / columnCounts[s.id]!).ceil() == maxDepth);

      for (var s in sectionsAtMaxDepth) {
        if (columnsRemaining > 0) {
          columnCounts.update(s.id, (x) => columnCounts[s.id]! + 1);
          columnsRemaining--;
        }
      }
    }

    return columnCounts;
  }

// done
  int depth(
    Layer l,
    Section s,
  ) {
    assert(layersSectionColumnCounts.isNotEmpty);
    return (s.components!.length / layersSectionColumnCounts[l.id]![s.id]!)
        .ceil();
  }
}

final modelCalculationsProvider = Provider.family<ModelInfo, String>(
  (ref, mid) {
    final model = ref.watch(modelProvider(mid));
    final settings = ref.watch(modelViewerSettingsProvider);

    return ModelInfo(model: model, settings: settings);
  },
);
