import 'dart:math';

import 'package:cbmui/providers/model_viewer_settings.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:http/http.dart' as http;
import 'models/component_business_model.dart';

double getTotalWidth(Model model, ModelViewSettings settings, bool isEditMode) {
  final w = 100 +
      ((settings.componentTotalSideLength * settings.layerMaxTotalColumns) +
          (((settings.sectionBorderWidth + settings.sectionPaddingWidth) * 2) *
              settings.layerMaxTotalColumns)) +
      settings.layerLabelAreaWidth +
      settings.layerSpacerWidth +
      (isEditMode
          ? settings.createButtonSizeLength *
              (maxSectionsInLayers(model.layers!) + 1)
          : 0);

  return w;
}

double calculateSectionWidth(Section section, int columnCount,
    ModelViewSettings settings, bool isEditMode) {
  final w = (settings.componentTotalSideLength * columnCount) +
      ((settings.sectionBorderWidth + settings.sectionPaddingWidth) * 2) +
      (isEditMode ? settings.createButtonSizeLength : 0);

  return w;
}

Map<String, int> calculateSectionColumnCounts(
    Layer layer, ModelViewSettings settings) {
  final sections = layer.sections!;
  final columnCounts = <String, int>{};

  int columnsRemaining = settings.layerMaxTotalColumns -
      sections.length * settings.sectionMinColumns;

  for (var s in sections) {
    columnCounts.putIfAbsent(s.id, () => settings.sectionMinColumns);
  }

  while (columnsRemaining > 0) {
    final maxDepth = sections.fold(
        0,
        (max, s) => depth(s, columnCounts[s.id]!) > max
            ? depth(s, columnCounts[s.id]!)
            : max);

    final sectionsAtMax =
        sections.where((s) => depth(s, columnCounts[s.id]!) == maxDepth);

    for (var s in sectionsAtMax) {
      if (columnsRemaining > 0) {
        columnCounts.update(s.id, (x) => columnCounts[s.id]! + 1);
        columnsRemaining--;
      }
    }
  }

  return columnCounts;
}

int maxSectionsInLayers(List<Layer> layers) {
  return layers.fold(
      0, (maxSections, l) => max(maxSections, l.sections!.length));
}

int depth(Section s, int columnCount) {
  return (s.components!.length / columnCount).ceil();
}

Component findComponent(String cid, Model model) {
  for (var l in model.layers!) {
    for (var s in l.sections!) {
      for (var c in s.components!) {
        if (c.id == cid) {
          return c;
        }
      }
    }
  }
  throw NullThrownError();
}

class ModelApi {
  static late Repository<Model> _repository;

  static setRepository(Repository<Model> repo) => _repository = repo;

  static Future<void> createModel() async {
    await sendPost(url: 'http://localhost:8888/models');
    await _repository.findAll(syncLocal: true);
  }

  static Future<void> deleteModel({required String id}) async {
    await sendDelete(url: 'http://localhost:8888/models/$id');
    await _repository.findAll(syncLocal: true);
  }

  static Future<void> saveModel({required Model model}) async {
    await model.save();
    await _repository.findAll(syncLocal: true);
  }

  static Future<void> createLayer({required Model model}) async {
    await sendPost(url: 'http://localhost:8888/models/${model.id}/layers');
    await _repository.findAll(syncLocal: true);
  }

  static Future<void> createSection(
      {required Model model, required Layer layer}) async {
    await sendPost(
        url:
            'http://localhost:8888/models/${model.id}/layers/${layer.id}/sections');

    await _repository.findAll(syncLocal: true);
  }

  static Future<void> createComponent({
    required Model model,
    required Layer layer,
    required Section section,
  }) async {
    await sendPost(
        url:
            'http://localhost:8888/models/${model.mid}/layers/${layer.id}/sections/${section.id}/components');

    await _repository.findAll(syncLocal: true);
  }

  static Future<void> sendPost({required String url}) async {
    await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: "{}",
    );
    return;
  }

  static Future<void> sendDelete({required String url}) async {
    await http.delete(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    return;
  }

  static Future<void> sendPut(
      {required String url, required Model model}) async {
    await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: Model,
    );
    return;
  }
}
