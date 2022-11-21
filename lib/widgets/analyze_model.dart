import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/component_business_model.dart';

class ModelAnalyzer extends ConsumerWidget {
  ModelAnalyzer({
    Key? key,
    required this.model,
  }) : super(key: key);

  final Model model;
  final List<Component> allComponents = <Component>[];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
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
    );
  }

  List<Component> getAllComponents() {
    if (allComponents.isEmpty) {
      for (var l in model.layers!) {
        for (var s in l.sections!) {
          for (var c in s.components!) {
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
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: 100,
                height: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(width: 1.0, color: Colors.black)),
                child: Text(
                  c.name,
                  textAlign: TextAlign.center,
                ),
              ),
            ))
        .toList();
  }

  Widget subquadrant(int strategic, int relationship) {
    const thickBorder = BorderSide(width: 6);
    const thinBorder = BorderSide(width: 1);

    return Container(
      // width: 200,
      // height: 200,
      decoration: BoxDecoration(
          border: Border(
        left: strategic.isOdd ? thickBorder : thinBorder,
        right: strategic.isEven ? thickBorder : thinBorder,
        top: relationship.isEven ? thickBorder : thinBorder,
        bottom: relationship.isOdd ? thickBorder : thinBorder,
      )),
      child: Wrap(
        key: ValueKey("$strategic,$relationship"),
        children: [
          ...getComponentViewersFor(
              strategic: strategic, relationship: relationship)
        ],
      ),
    );
  }
}
