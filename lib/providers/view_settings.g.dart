// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'view_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ViewSettings _$$_ViewSettingsFromJson(Map<String, dynamic> json) =>
    _$_ViewSettings(
      showSettingsView: json['showSettingsView'] as bool? ?? false,
      subquadrantMinWidth:
          (json['subquadrantMinWidth'] as num?)?.toDouble() ?? 350,
      subquadrantMinHeight:
          (json['subquadrantMinHeight'] as num?)?.toDouble() ?? 350,
      subquadrantMaxWidth:
          (json['subquadrantMaxWidth'] as num?)?.toDouble() ?? 500,
      subquadrantMaxHeight:
          (json['subquadrantMaxHeight'] as num?)?.toDouble() ?? 500,
      subquadrantThickBorderWidth:
          (json['subquadrantThickBorderWidth'] as num?)?.toDouble() ?? 6,
      subquadrantThinBorderWidth:
          (json['subquadrantThinBorderWidth'] as num?)?.toDouble() ?? 1,
      analyzeSubtitleFontSize:
          (json['analyzeSubtitleFontSize'] as num?)?.toDouble() ?? 24,
      layerMaxTotalColumns: json['layerMaxTotalColumns'] as int? ?? 15,
      sectionMinColumns: json['sectionMinColumns'] as int? ?? 2,
      componentLabelWidth:
          (json['componentLabelWidth'] as num?)?.toDouble() ?? 100,
      componentDropIndicatorWidth:
          (json['componentDropIndicatorWidth'] as num?)?.toDouble() ?? 8,
      componentColor: json['componentColor'] ?? Colors.white,
      componentIsRatedColor:
          json['componentIsRatedColor'] ?? Colors.lightBlueAccent,
      componentLabelFontSize:
          (json['componentLabelFontSize'] as num?)?.toDouble() ?? 14,
      componentLabelFontWeight:
          json['componentLabelFontWeight'] ?? FontWeight.normal,
      componentLabelMaxLines: json['componentLabelMaxLines'] as int? ?? 3,
      sectionBorderWidth: (json['sectionBorderWidth'] as num?)?.toDouble() ?? 1,
      sectionLabelFontSize:
          (json['sectionLabelFontSize'] as num?)?.toDouble() ?? 20,
      sectionLabelFontWeight: json['sectionLabelFontWeight'] ?? FontWeight.bold,
      sectionLabelMaxLines: json['sectionLabelMaxLines'] as int? ?? 1,
      sectionBorderColor: json['sectionBorderColor'] ?? Colors.black,
      sectionColor: json['sectionColor'] ?? Colors.white,
      layerLabelWidth: (json['layerLabelWidth'] as num?)?.toDouble() ?? 250,
      layerSpacerWidth: (json['layerSpacerWidth'] as num?)?.toDouble() ?? 20,
      layerLabelFontSize:
          (json['layerLabelFontSize'] as num?)?.toDouble() ?? 32,
      layerPaddingWidth: (json['layerPaddingWidth'] as num?)?.toDouble() ?? 5,
      layerLabelFontWeight: json['layerLabelFontWeight'] ?? FontWeight.bold,
      layerLabelMaxLines: json['layerLabelMaxLines'] as int? ?? 3,
      modelViewerPaddingWidth:
          (json['modelViewerPaddingWidth'] as num?)?.toDouble() ?? 30,
      elevation: (json['elevation'] as num?)?.toDouble() ?? 2,
    );

Map<String, dynamic> _$$_ViewSettingsToJson(_$_ViewSettings instance) =>
    <String, dynamic>{
      'showSettingsView': instance.showSettingsView,
      'subquadrantMinWidth': instance.subquadrantMinWidth,
      'subquadrantMinHeight': instance.subquadrantMinHeight,
      'subquadrantMaxWidth': instance.subquadrantMaxWidth,
      'subquadrantMaxHeight': instance.subquadrantMaxHeight,
      'subquadrantThickBorderWidth': instance.subquadrantThickBorderWidth,
      'subquadrantThinBorderWidth': instance.subquadrantThinBorderWidth,
      'analyzeSubtitleFontSize': instance.analyzeSubtitleFontSize,
      'layerMaxTotalColumns': instance.layerMaxTotalColumns,
      'sectionMinColumns': instance.sectionMinColumns,
      'componentLabelWidth': instance.componentLabelWidth,
      'componentDropIndicatorWidth': instance.componentDropIndicatorWidth,
      'componentColor': instance.componentColor,
      'componentIsRatedColor': instance.componentIsRatedColor,
      'componentLabelFontSize': instance.componentLabelFontSize,
      'componentLabelFontWeight': instance.componentLabelFontWeight,
      'componentLabelMaxLines': instance.componentLabelMaxLines,
      'sectionBorderWidth': instance.sectionBorderWidth,
      'sectionLabelFontSize': instance.sectionLabelFontSize,
      'sectionLabelFontWeight': instance.sectionLabelFontWeight,
      'sectionLabelMaxLines': instance.sectionLabelMaxLines,
      'sectionBorderColor': instance.sectionBorderColor,
      'sectionColor': instance.sectionColor,
      'layerLabelWidth': instance.layerLabelWidth,
      'layerSpacerWidth': instance.layerSpacerWidth,
      'layerLabelFontSize': instance.layerLabelFontSize,
      'layerPaddingWidth': instance.layerPaddingWidth,
      'layerLabelFontWeight': instance.layerLabelFontWeight,
      'layerLabelMaxLines': instance.layerLabelMaxLines,
      'modelViewerPaddingWidth': instance.modelViewerPaddingWidth,
      'elevation': instance.elevation,
    };
