import 'package:cbmui/widgets/label_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cbmui/main.data.dart';
import '../models/component_business_model.dart';
import '../util.dart';

class ComponentViewer extends ConsumerWidget {
  const ComponentViewer._(
      {super.key,
      this.component,
      required this.section,
      required this.model,
      required this.layer,
      this.createComponentWidget = false});

  factory ComponentViewer.createButton({
    required Model model,
    required Layer layer,
    required Section section,
  }) {
    return ComponentViewer._(
      model: model,
      layer: layer,
      section: section,
      createComponentWidget: true,
    );
  }

  factory ComponentViewer.contentWidget({
    required Model model,
    required Layer layer,
    required Section section,
    required Component component,
  }) {
    return ComponentViewer._(
      key: ValueKey(component.id),
      model: model,
      layer: layer,
      section: section,
      component: component,
    );
  }

  final Component? component;
  final Section section;
  final Layer layer;
  final Model model;
  final bool createComponentWidget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (createComponentWidget) {
      return ElevatedButton(
        onPressed: () async {
          await ModelApi.createComponent(
              repository: ref.models,
              model: model,
              layer: layer,
              section: section);
          return;
        },
        style: createButtonStyle.copyWith(
            fixedSize: const MaterialStatePropertyAll(Size(10, 60))),
        child: const Icon(Icons.add_box),
      );
    } else {
      return SizedBox(
        width: 100,
        height: 100,
        child: Card(
          elevation: 3,
          child: Center(
            child: LabelWidget(
              label: component!.name,
              width: 80,
              fontSize: 14,
              fontWeight: FontWeight.normal,
              alignment: TextAlign.center,
              onChanged: (s) async {
                component!.name = s;
                await ModelApi.saveModel(
                  repository: ref.models,
                  model: model,
                );
              },
            ),
          ),
        ),
      );
    }
  }
}
