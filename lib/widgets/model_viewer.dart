import 'package:cbmui/models/component_business_model.dart';
import 'package:cbmui/widgets/layer_viewer.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ModelViewer extends ConsumerWidget {
  const ModelViewer({super.key, required this.model});

  final Model model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Text(
          model.name,
          style: const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: model.layers!.map((l) => LayerViewer(layer: l)).toList(),
          ),
        ),
      ],
    );
  }
}
