import 'dart:async';

import 'package:cbmui/providers/model_info_provider.dart';
import 'package:cbmui/widgets/edit_buttons.dart';
import 'package:cbmui/widgets/horizontal_drop_zone.dart';
import 'package:cbmui/widgets/relationship_widget.dart';
import 'package:cbmui/widgets/strategic_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/component_business_model.dart';
import '../providers/mode_provider.dart';
import '../api/model_api.dart';
import 'label_widget.dart';

class ComponentViewer extends ConsumerStatefulWidget {
  const ComponentViewer({
    super.key,
    required this.component,
    required this.sid,
    required this.mid,
    required this.lid,
  });

  final Component component;
  final String sid;
  final String lid;
  final String mid;

  @override
  ConsumerState<ComponentViewer> createState() => _ComponentViewerState();
}

class _ComponentViewerState extends ConsumerState<ComponentViewer> {
  late final TextEditingController notesController;
  Timer timer = Timer(const Duration(milliseconds: 0), () {});

  @override
  void initState() {
    super.initState();
    notesController = TextEditingController(
      text: widget.component.notes,
    );
  }

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final modelInfo = ref.watch(modelInfoProvider(widget.mid));
    final model = modelInfo.model;
    final layer = model.findLayer(widget.lid);
    final section = layer.findSection(widget.sid);
    final settings = modelInfo.settings;
    final c = widget.component;
    final isRated = c.strategic > 0 && c.relationship > 0;

    void onNotesChanged(String s) {
      timer.cancel();
      timer = Timer(const Duration(milliseconds: 1500), () async {
        widget.component.notes = s;
        await ModelApi.saveModel(model: model);
        timer.cancel();
      });
    }

    Future<void> ratingDialog(BuildContext context) {
      final c = widget.component;

      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 400,
                maxWidth: 800,
                minHeight: 400,
                maxHeight: 800,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      c.name,
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: StrategicWidget(
                      componentId: c.id,
                      model: model,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: RelationshipWidget(
                      componentId: c.id,
                      model: model,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      minLines: 3,
                      maxLines: 20,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      controller: notesController,
                      onChanged: (s) => onNotesChanged(s),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.check_circle,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return GestureDetector(
      onTap: () async {
        if (ref.read(isModelViewerViewModeProvider)) {
          await ratingDialog(context);
        }
      },
      child: HorizontalDoubleDropZone(
        model: model,
        id: widget.component.id,
        type: "component",
        indicatorWidth: settings.componentDropIndicatorWidth,
        onDrop: model.moveComponent,
        child: SizedBox(
          width: settings.componentBaseSideLength,
          height: settings.componentBaseSideLength,
          child: Card(
            elevation: settings.elevation,
            color: isRated
                ? settings.componentIsRatedColor
                : settings.componentColor,
            child: Stack(
              children: [
                Center(
                  child: LabelWidget(
                    label: c.name,
                    width: settings.componentLabelWidth,
                    fontSize: settings.componentLabelFontSize,
                    fontWeight: settings.componentLabelFontWeight,
                    alignment: TextAlign.center,
                    maxlines: 4,
                    onChanged: (s) async {
                      c.name = s;
                      await ModelApi.saveModel(
                        model: model,
                      );
                    },
                  ),
                ),
                EditButtons(
                  onDelete: () async {
                    section.components!.removeWhere((t) => c.id == t.id);
                    await ModelApi.saveModel(
                      model: model,
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
