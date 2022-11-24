import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_data/flutter_data.dart';

part 'model_viewer_settings.g.dart';

@CopyWith()
class ModelViewSettings {
  final double componentTotalSideLength;
  final double componentLabelPadding;
  final double componentPaddingWidth;
  final double componentBorderWidth;
  final Color componentIsRatedBorderColor;
  final Color componentDefaultBorderColor;
  final Color componentColor;
  final double componentLabelFontSize;
  final FontWeight componentLabelFontWeight;
  final int componentLabelMaxLines;
  final double sectionPaddingWidth;
  final double sectionBorderWidth;
  final double sectionLabelFontSize;
  final FontWeight sectionLabelFontWeight;
  final int sectionLabelMaxLines;
  final Color sectionBorderColor;
  final Color sectionColor;
  final int minMultiSectionComponentRun;
  final int maxMultiSectionComponentRun;
  final int minSingleSectionComponentRun;
  final int maxSingleSectionComponentRun;
  final double layerLabelAreaWidth;
  final double layerSpacerWidth;
  final double layerLabelFontSize;
  final FontWeight layerLabelFontWeight;
  final int layerLabelMaxLines;
  final double layerPaddingWidth;
  final int layerMaxTotalColumns;
  final int sectionMinColumns;
  final double mininumTotalWidth;
  final double maximumTotalWidth;
  final double createButtonSizeLength;

  ModelViewSettings({
    this.layerMaxTotalColumns = 12,
    this.sectionMinColumns = 1,
    this.componentTotalSideLength = 120,
    this.componentLabelPadding = 8,
    this.componentPaddingWidth = 3,
    this.componentBorderWidth = 2,
    this.componentIsRatedBorderColor = Colors.green,
    this.componentDefaultBorderColor = Colors.transparent,
    this.componentColor = Colors.white,
    this.componentLabelFontSize = 14,
    this.componentLabelFontWeight = FontWeight.normal,
    this.componentLabelMaxLines = 3,
    this.sectionPaddingWidth = 5,
    this.sectionBorderWidth = 1,
    this.sectionLabelFontSize = 20,
    this.sectionLabelFontWeight = FontWeight.bold,
    this.sectionLabelMaxLines = 1,
    this.sectionBorderColor = Colors.black,
    this.sectionColor = Colors.white,
    this.minMultiSectionComponentRun = 2,
    this.maxMultiSectionComponentRun = 8,
    this.minSingleSectionComponentRun = 2,
    this.maxSingleSectionComponentRun = 8,
    this.layerLabelAreaWidth = 250,
    this.layerSpacerWidth = 20,
    this.layerLabelFontSize = 32,
    this.layerPaddingWidth = 5,
    this.layerLabelFontWeight = FontWeight.bold,
    this.layerLabelMaxLines = 3,
    this.mininumTotalWidth = 500,
    this.maximumTotalWidth = 2000,
    this.createButtonSizeLength = 40,
  });

  double get componentSideLength =>
      componentTotalSideLength - componentPaddingWidth - componentBorderWidth;
}

class ModelViewerSettingsNotifier extends StateNotifier<ModelViewSettings> {
  ModelViewerSettingsNotifier(super.state);

  void updateSettings(ModelViewSettings settings) => state = settings;
}

final modelViewerSettingsProvider =
    StateNotifierProvider<ModelViewerSettingsNotifier, ModelViewSettings>(
        (_) => ModelViewerSettingsNotifier(ModelViewSettings()));
