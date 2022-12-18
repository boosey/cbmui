import 'dart:async';

import 'package:cbmui/providers/model_info_provider.dart';
import 'package:cbmui/widgets/edit_buttons.dart';
import 'package:cbmui/widgets/horizontal_drop_zone.dart';
import 'package:cbmui/widgets/ibm_divisions_selector.dart';
import 'package:cbmui/widgets/relationship_area.dart';
import 'package:cbmui/widgets/relationship_widget.dart';
import 'package:cbmui/widgets/strategic_widget.dart';
import 'package:cbmui/widgets/tags_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/component_business_model.dart';
import '../providers/mode_provider.dart';
import '../api/model_api.dart';
import 'label_widget.dart';

class ComponentViewer extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final modelInfo = ref.watch(modelInfoProvider(mid));
    final model = modelInfo.model;
    final layer = model.findLayer(lid);
    final section = layer.findSection(sid);
    final settings = modelInfo.settings;
    final isRated = component.strategic > 0 && component.relationship > 0;

    Future<void> ratingDialog(BuildContext context) {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: RatingDialog(component: component, model: model),
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
        id: component.id,
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
                    label: component.name,
                    width: settings.componentLabelWidth,
                    fontSize: settings.componentLabelFontSize,
                    fontWeight: settings.componentLabelFontWeight,
                    alignment: TextAlign.center,
                    maxlines: 4,
                    onChanged: (s) async {
                      component.name = s;
                      await ModelApi.saveModel(
                        model: model,
                      );
                    },
                  ),
                ),
                EditButtons(
                  onDelete: () async {
                    section.components!
                        .removeWhere((t) => component.id == t.id);
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

class RatingDialog extends StatefulWidget {
  const RatingDialog({
    Key? key,
    required this.component,
    required this.model,
  }) : super(key: key);

  final Component component;
  final Model model;

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  late final TextEditingController notesController;
  late final TextEditingController lobContactController;
  late final TextEditingController adContactController;
  late final TextEditingController opsContactController;
  Timer timer = Timer(const Duration(milliseconds: 0), () {});

  @override
  void initState() {
    super.initState();
    notesController = TextEditingController(text: widget.component.notes);
    lobContactController =
        TextEditingController(text: widget.component.businessContact);
    adContactController =
        TextEditingController(text: widget.component.appDevContact);
    opsContactController =
        TextEditingController(text: widget.component.opsInfraContact);
  }

  @override
  void dispose() {
    notesController.dispose();
    lobContactController.dispose();
    adContactController.dispose();
    opsContactController.dispose();
    super.dispose();
  }

  void onNotesChanged(String s) {
    onTextChanged(() => widget.component.notes = s);
  }

  void onTextChanged(void Function() updateField) {
    timer.cancel();
    timer = Timer(const Duration(milliseconds: 1500), () async {
      updateField.call();
      await ModelApi.saveModel(model: widget.model);
      timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 400,
        maxWidth: 800,
        minHeight: 400,
        maxHeight: 800,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                widget.component.name,
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: StrategicWidget(
                    componentId: widget.component.id,
                    model: widget.model,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: RelationshipWidget(
                    componentId: widget.component.id,
                    model: widget.model,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: const BoxDecoration(
                  border: Border.symmetric(
                    vertical: BorderSide(),
                    horizontal: BorderSide(),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: IBMDivisionSelector(
                              component: widget.component,
                              model: widget.model,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: RelationshipArea(
                              component: widget.component,
                              model: widget.model,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 250,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: TextField(
                                decoration: const InputDecoration(
                                  labelText: "Business Contact",
                                  border: OutlineInputBorder(),
                                ),
                                controller: lobContactController,
                                onChanged: (s) => onTextChanged(
                                    () => widget.component.businessContact = s),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 250,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: TextField(
                                decoration: const InputDecoration(
                                  labelText: "Application Development Contact",
                                  border: OutlineInputBorder(),
                                ),
                                controller: adContactController,
                                onChanged: (s) => onTextChanged(
                                    () => widget.component.appDevContact = s),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 250,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: TextField(
                                decoration: const InputDecoration(
                                  labelText: "Operations Contact",
                                  border: OutlineInputBorder(),
                                ),
                                controller: opsContactController,
                                onChanged: (s) => onTextChanged(
                                    () => widget.component.opsInfraContact = s),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                minLines: 3,
                maxLines: 20,
                decoration: const InputDecoration(
                  labelText: "Notes",
                  border: OutlineInputBorder(),
                ),
                controller: notesController,
                onChanged: (s) => onNotesChanged(s),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ComponentTags(
                component: widget.component,
                model: widget.model,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: IconButton(
                      iconSize: 36,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.check_circle,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      widget.component.relationship = 0;
                      widget.component.strategic = 0;
                      widget.component.isIbmConsulting = false;
                      widget.component.isIbmTechnology = false;
                      widget.component.isAppDev = false;
                      widget.component.isBusiness = false;
                      widget.component.isOpsInfra = false;
                      widget.component.appDevContact = "";
                      widget.component.businessContact = "";
                      widget.component.opsInfraContact = "";
                      widget.component.notes = "";
                      widget.component.tags = {};

                      adContactController.text = "";
                      lobContactController.text = "";
                      opsContactController.text = "";

                      await ModelApi.saveModel(model: widget.model);
                    },
                    child: const Text("Clear"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
