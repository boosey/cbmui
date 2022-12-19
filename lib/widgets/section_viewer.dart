import 'dart:math';

import 'package:cbmui/providers/model_info_provider.dart';
import 'package:cbmui/providers/view_settings.dart';
import 'package:cbmui/widgets/create_object_button.dart';

import 'package:cbmui/widgets/edit_buttons.dart';
import 'package:cbmui/widgets/horizontal_drop_zone.dart';
import 'package:cbmui/widgets/label_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/model_api.dart';
import 'component_viewer.dart';

class SectionViewer extends ConsumerWidget {
  const SectionViewer({
    super.key,
    required this.sid,
    this.displayLabel = false,
    required this.mid,
    required this.lid,
    required this.columnCount,
    required this.width,
  });

  final String sid;
  final String mid;
  final String lid;
  final int columnCount;
  final double width;
  final bool displayLabel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Widget mainWidget;

    final modelInfo = ref.watch(modelInfoProvider(mid));
    final model = modelInfo.model;
    final layer = model.findLayer(lid);
    final section = layer.findSection(sid);
    final settings = modelInfo.settings;

    final componentsWidgets = section.components
        .map(
          (c) => ComponentViewer(
            component: c,
            sid: section.id,
            lid: layer.id,
            mid: model.id,
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
          await ModelApi.saveCBModel(
            model: model,
          );
        },
      ),
    );

    Widget sectionContent(
        List<Widget> componentsWidgets, ViewSettings settings) {
      List<Row> rows = [];

      for (var i = 0; i < componentsWidgets.length; i += columnCount) {
        final take = min(i + columnCount, componentsWidgets.length);
        final List<Widget> cWidgets = componentsWidgets.sublist(i, take);
        late List<Widget> allWidgets;
        if (take == componentsWidgets.length) {
          allWidgets = [
            ...cWidgets,
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

      return SizedBox(
        width: settings.calculateBaseSectionWidth(width, settings),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
            width: settings.sectionBorderWidth,
            color: settings.sectionBorderColor,
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CreateButton(
                label: "Component",
                onChanged: () async => await ModelApi.createComponent(
                  model: model,
                  layer: layer,
                  section: section,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 8,
                ),
                child: Column(
                  children: rows,
                ),
              ),
            ],
          ),
        ),
      );
    }

    mainWidget = HorizontalDoubleDropZone(
      id: section.id,
      indicatorWidth: settings.componentDropIndicatorWidth,
      model: model,
      type: 'section',
      onDrop: model.moveSection,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: width,
            child: Row(
              children: [
                EditButtons(
                  onDelete: () async {
                    await model.deleteSection(
                      lid,
                      sid,
                    );
                  },
                ),
                Expanded(child: label),
              ],
            ),
          ),
          sectionContent(componentsWidgets, settings),
        ],
      ),
    );

    return mainWidget;
  }
}
