import 'dart:math';

import 'package:cbmui/providers/model_viewer_settings.dart';
import 'package:cbmui/widgets/create_object_button.dart';
import 'package:cbmui/widgets/deletable.dart';
import 'package:cbmui/widgets/label_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/component_business_model.dart';
import '../util.dart';
import 'component_viewer.dart';

class SectionViewer extends ConsumerWidget {
  const SectionViewer({
    super.key,
    required this.section,
    this.displayLabel = false,
    required this.model,
    required this.layer,
    required this.columnCount,
    required this.width,
  });

  final Section section;
  final bool displayLabel;
  final Model model;
  final Layer layer;
  final int columnCount;
  final double width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Widget mainWidget;

    final settings = ref.watch(modelViewerSettingsProvider);

    final componentsWidgets = section.components!
        .map(
          (c) => ComponentViewer(
            component: c,
            section: section,
            layer: layer,
            model: model,
          ),
        )
        .toList();

    var label = Visibility(
      visible: displayLabel,
      child: LabelWidget(
        label: section.name,
        fontSize: settings.sectionLabelFontSize,
        width: width,
        onChanged: (s) async {
          section.name = s;
          await ModelApi.saveModel(
            model: model,
          );
        },
      ),
    );

    mainWidget = DeletableOrMoveable(
      onDeleteRequested: () async {
        layer.sections!.removeWhere((s) => section.id == s.id);
        await ModelApi.saveModel(
          model: model,
        );
      },
      child: Padding(
        padding: EdgeInsets.all(settings.sectionPaddingWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            label,
            sectionContent(componentsWidgets, settings),
          ],
        ),
      ),
    );

    return mainWidget;
  }

  Widget sectionContent(
      List<Widget> componentsWidgets, ModelViewSettings settings) {
    List<Row> rows = [];

    for (var i = 0; i < componentsWidgets.length; i += columnCount) {
      final take = min(i + columnCount, componentsWidgets.length);
      final List<Widget> cWidgets = componentsWidgets.sublist(i, take);
      late List<Widget> allWidgets;
      if (take == componentsWidgets.length) {
        allWidgets = [
          ...cWidgets,
          CreateButton(
            onChanged: () async => await ModelApi.createComponent(
              model: model,
              layer: layer,
              section: section,
            ),
          ),
        ];
      } else {
        allWidgets = cWidgets;
      }

      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: allWidgets,
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
          border: Border.all(
        width: settings.sectionBorderWidth,
        color: settings.sectionBorderColor,
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: rows,
      ),
    );
  }
}
