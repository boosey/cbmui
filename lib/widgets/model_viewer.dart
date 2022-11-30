import 'package:cbmui/providers/model_info_provider.dart';

import 'package:cbmui/providers/view_settings.dart';

import 'package:cbmui/widgets/create_object_button.dart';
import 'package:cbmui/widgets/mode_selector.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/component_business_model.dart';
import '../providers/mode_provider.dart';

import '../api/model_api.dart';
import 'analyze_model.dart';
import 'label_widget.dart';
import 'layer_viewer.dart';

class ModelViewer extends ConsumerWidget {
  const ModelViewer({
    super.key,
    required this.mid,
  });

  final String mid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAnalyzeMode = ref.watch(isModelViewerAnalyzeModeProvider);
    final isEditMode = ref.watch(isModelViewerEditModeProvider);
    final modelInfo = ref.watch(modelInfoProvider(mid));
    final model = modelInfo.model;
    final settings = modelInfo.settings;

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
                    // const Zoom(),
                    const SizedBox(
                      width: 20,
                      height: 1,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: ModeSelector(),
                    ),
                  ],
                ),
                CreateButton(
                  key: const ValueKey("layercreatebutton"),
                  label: "Layer",
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
                      isEditMode: isEditMode,
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Widget view({
    required Model model,
    required bool isAnalyzeMode,
    required ViewSettings settings,
    required bool isEditMode,
  }) {
    return isAnalyzeMode
        ? ModelAnalyzer(model: model)
        : LayoutBuilder(
            builder: (context, viewportConstraints) => SingleChildScrollView(
              controller: ScrollController(),
              scrollDirection: Axis.vertical,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: EdgeInsets.all(settings.modelViewerPaddingWidth),
                    child: InteractiveViewer(
                      boundaryMargin: const EdgeInsets.all(double.infinity),
                      minScale: 0.5,
                      maxScale: 3.0,
                      constrained: true,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            // ignore: sized_box_for_whitespace
                            child: Container(
                              width: 10,
                              height: 1,
                            ),
                          ),
                          ...model.layers!.map(
                            (l) {
                              return layerViewer(
                                l,
                                model,
                                settings,
                                isEditMode,
                              );
                            },
                          ).toList(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  Widget layerViewer(
      Layer l, Model model, ViewSettings settings, bool isEditMode) {
    return LayerViewer(
      key: ValueKey("layerviewer${l.id}"),
      lid: l.id,
      mid: model.mid,
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
