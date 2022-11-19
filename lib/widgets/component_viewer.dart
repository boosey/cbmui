import 'dart:async';

import 'package:cbmui/widgets/relationship_widget.dart';
import 'package:cbmui/widgets/strategic_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/component_business_model.dart';
import '../providers/mode_provider.dart';
import '../util.dart';
import 'label_widget.dart';

class ComponentViewer extends ConsumerStatefulWidget {
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
  ConsumerState<ComponentViewer> createState() => _ComponentViewerState();
}

class _ComponentViewerState extends ConsumerState<ComponentViewer> {
  late final TextEditingController notesController;
  Timer timer = Timer(const Duration(milliseconds: 0), () {});

  @override
  void initState() {
    super.initState();
    notesController = TextEditingController(
      text: widget.component?.notes ?? "",
    );
  }

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  void onNotesChanged(String s) {
    timer.cancel();
    timer = Timer(const Duration(milliseconds: 1500), () async {
      widget.component!.notes = s;
      await ModelApi.saveModel(model: widget.model);
      timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isEditMode = ref.watch(isModelViewerEditModeProvider);

    if (widget.createComponentWidget) {
      return IconButton(
        icon: const Icon(Icons.add_box),
        color: Colors.blue,
        onPressed: () async {
          await ModelApi.createComponent(
              model: widget.model,
              layer: widget.layer,
              section: widget.section);
          return;
        },
        // style: createButtonStyle.copyWith(
        //     fixedSize: const MaterialStatePropertyAll(Size(10, 60))),
      );
    } else {
      return Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (ref.read(isModelViewerViewModeProvider)) {
                _ratingDialog(context);
              }
            },
            child: SizedBox(
              width: 100,
              height: 100,
              child: Card(
                elevation: 3,
                child: Center(
                  child: LabelWidget(
                    label: widget.component!.name,
                    width: 80,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    alignment: TextAlign.center,
                    onChanged: (s) async {
                      widget.component!.name = s;
                      await ModelApi.saveModel(
                        model: widget.model,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: isEditMode && !widget.createComponentWidget,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () async {
                widget.section.components!
                    .removeWhere((c) => widget.component!.id == c.id);
                await ModelApi.saveModel(
                  model: widget.model,
                );
              },
            ),
          ),
        ],
      );
    }
  }

  Future<void> _ratingDialog(BuildContext context) {
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
                    widget.component!.name,
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: StrategicWidget(
                    component: widget.component!,
                    model: widget.model,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: RelationshipWidget(
                    component: widget.component!,
                    model: widget.model,
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
                    onPressed: () => Navigator.of(context).pop(),
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
}
