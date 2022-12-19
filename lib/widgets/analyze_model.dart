import 'package:cbmui/providers/model_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/cbmodel.dart';
import '../models/component.dart';

class ModelAnalyzer extends ConsumerWidget {
  ModelAnalyzer({
    Key? key,
    required this.model,
  }) : super(key: key);

  final CBModel model;
  final List<Component> allComponents = <Component>[];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mi = ref.watch(modelInfoProvider(model.id));
    final settings = mi.settings;
    final analyzeSubtitleStyle =
        TextStyle(fontSize: settings.analyzeSubtitleFontSize);

    Widget subquadrant(int strategic, int relationship) {
      final thickBorder =
          BorderSide(width: settings.subquadrantThickBorderWidth);
      final thinBorder = BorderSide(width: settings.subquadrantThinBorderWidth);

      return Container(
        decoration: BoxDecoration(
            border: Border(
          left: strategic.isOdd ? thickBorder : thinBorder,
          right: strategic.isEven ? thickBorder : thinBorder,
          top: relationship.isEven ? thickBorder : thinBorder,
          bottom: relationship.isOdd ? thickBorder : thinBorder,
        )),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: settings.subquadrantMinWidth,
            minHeight: settings.subquadrantMinHeight,
            maxWidth: settings.subquadrantMinWidth,
          ),
          child: Wrap(
            key: ValueKey("$strategic,$relationship"),
            children: [
              ...getComponentViewersFor(
                  strategic: strategic, relationship: relationship)
            ],
            // ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: InteractiveViewer(
        boundaryMargin: const EdgeInsets.all(double.infinity),
        minScale: 0.5,
        maxScale: 3.0,
        constrained: true,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: ((settings.subquadrantMinWidth +
                    settings.subquadrantThickBorderWidth +
                    settings.subquadrantThinBorderWidth) *
                4),
            minHeight: (settings.subquadrantMinHeight +
                    settings.subquadrantThickBorderWidth +
                    settings.subquadrantThinBorderWidth) *
                4,
            maxWidth: ((settings.subquadrantMinWidth +
                    settings.subquadrantThickBorderWidth +
                    settings.subquadrantThinBorderWidth) *
                4),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Column(
                  children: [
                    Text("Importance", style: analyzeSubtitleStyle),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("None", style: analyzeSubtitleStyle),
                        Text("Neutral", style: analyzeSubtitleStyle),
                        Text("Tactical", style: analyzeSubtitleStyle),
                        Text("Strategic", style: analyzeSubtitleStyle),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          subquadrant(1, 4),
                          subquadrant(2, 4),
                        ],
                      ),
                      Row(
                        children: [
                          subquadrant(1, 3),
                          subquadrant(2, 3),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          subquadrant(3, 4),
                          subquadrant(4, 4),
                        ],
                      ),
                      Row(
                        children: [
                          subquadrant(3, 3),
                          subquadrant(4, 3),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          subquadrant(1, 2),
                          subquadrant(2, 2),
                        ],
                      ),
                      Row(
                        children: [
                          subquadrant(1, 1),
                          subquadrant(2, 1),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          subquadrant(3, 2),
                          subquadrant(4, 2),
                        ],
                      ),
                      Row(
                        children: [
                          subquadrant(3, 1),
                          subquadrant(4, 1),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Component> getAllComponents() {
    if (allComponents.isEmpty) {
      for (var l in model.layers) {
        for (var s in l.sections) {
          for (var c in s.components) {
            allComponents.add(c);
          }
        }
      }
    }
    return allComponents;
  }

  List<Component> getComponentsFor(
      {required int strategic, required int relationship}) {
    final list = getAllComponents()
        .where(
            (c) => c.strategic == strategic && c.relationship == relationship)
        .toList();

    return list;
  }

  List<Widget> getComponentViewersFor(
      {required int strategic, required int relationship}) {
    return getComponentsFor(strategic: strategic, relationship: relationship)
        .map((c) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 100,
                height: 100,
                child: Card(
                  color: Color.fromRGBO(
                    0,
                    225,
                    0,
                    (strategic * relationship) / 16,
                  ),
                  child: Align(
                    child: Text(
                      c.name,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ))
        .toList();
  }
}
