import 'package:cbmui/models/component_business_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ModelThumbnail extends ConsumerWidget {
  const ModelThumbnail({super.key, required this.model});

  final Model model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...model.layers!.map(
          (l) {
            return layerThumbnail(l);
          },
        ).toList(),
      ],
    );
  }

  Widget layerThumbnail(Layer l) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              l.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
          ),
        ),
        Flexible(
          flex: 4,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...l.sections!.reversed.map(
                (s) => Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: sectionThumbnail(s),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget sectionThumbnail(Section s) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(width: 2.0, color: Colors.black)),
      child: Wrap(
        direction: Axis.horizontal,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 2,
        runSpacing: 2,
        children: s.components!
            .map(
              (c) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: componentThumbnail(c),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget componentThumbnail(Component c) {
    return Container(
      width: 100,
      height: 100,
      alignment: Alignment.center,
      decoration:
          BoxDecoration(border: Border.all(width: 1.0, color: Colors.black)),
      child: Text(
        c.name,
        textAlign: TextAlign.center,
      ),
    );
  }
}
