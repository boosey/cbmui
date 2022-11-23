import 'package:cbmui/providers/model_provider.dart';
import 'package:cbmui/providers/model_viewer_settings.dart';
import 'package:cbmui/widgets/create_object_button.dart';
import 'package:cbmui/widgets/mode_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/component_business_model.dart';
import '../providers/mode_provider.dart';
import '../util.dart';
import 'analyze_model.dart';
import 'label_widget.dart';
import 'layer_viewer.dart';

class ModelViewer2 extends ConsumerWidget {
  const ModelViewer2({
    super.key,
    required this.mid,
  });

  final String mid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAnalyzeMode = ref.watch(isModelViewerAnalyzeModeProvider);
    final isEditMode = ref.watch(isModelViewerEditModeProvider);
    final settings = ref.watch(modelViewerSettingsProvider);
    final model = ref.watch(modelProvider(mid));

    var modelNameLabel = Expanded(
      child: LabelWidget(
        label: model.name,
        onChanged: (s) async {
          model.name = s;
          await ModelApi.saveModel(
            model: model,
          );
        },
      ),
    );

    return mid.isEmpty
        ? Container()
        : Scaffold(
            body: Column(
              children: [
                Row(
                  children: [
                    backButton(ref, context),
                    modelNameLabel,
                    const ModeSelector(),
                  ],
                ),
                CreateButton(
                  key: const ValueKey("layercreatebutton"),
                  onChanged: () async {
                    await ModelApi.createLayer(model: model);
                  },
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: view(
                        model: model,
                        isAnalyzeMode: isAnalyzeMode,
                        settings: settings,
                        isEditMode: isEditMode),
                  ),
                ),
              ],
            ),
          );
  }

  Widget view(
      {required Model model,
      required bool isAnalyzeMode,
      required ModelViewSettings settings,
      required bool isEditMode}) {
    return isAnalyzeMode
        ? ModelAnalyzer(model: model)
        : ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: getTotalWidth(model, settings, isEditMode) * 1.1,
              maxWidth: getTotalWidth(model, settings, isEditMode) * 1.2,
            ),
            child: ReorderableListView(
              reverse: true,
              buildDefaultDragHandles: true,
              // onReorder: reorderLayers,
              onReorder: (i, j) {},
              children: model.layers!.reversed.map(
                (l) {
                  return layerViewer(l, model, settings, isEditMode);
                },
              ).toList(),
            ),
          );
  }

  Widget layerViewer(
      Layer l, Model model, ModelViewSettings settings, bool isEditMode) {
    return ConstrainedBox(
      key: ValueKey("layerbox${l.id}"),
      constraints: BoxConstraints(
        minWidth: getTotalWidth(model, settings, isEditMode),
        maxWidth: getTotalWidth(model, settings, isEditMode) * 1.09,
      ),
      child: LayerViewer(
        key: ValueKey("layerviewer${l.id}"),
        layer: l,
        model: model,
      ),
    );
  }

  Padding backButton(WidgetRef ref, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 30, 8),
      child: IconButton(
        onPressed: () {
          ref.read(modelViewerModeProvider.notifier).view();
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }
}
