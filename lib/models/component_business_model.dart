import 'package:flutter_data/flutter_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

import '../api/model_api.dart';

part 'component_business_model.g.dart';

mixin ModelAdapter on RemoteAdapter<Model> {
  @override
  DataRequestMethod methodForSave(id, Map<String, dynamic> params) =>
      id != null ? DataRequestMethod.PUT : DataRequestMethod.POST;

  @override
  String get baseUrl => 'http://localhost:8888/';
  // String get baseUrl => const String.fromEnvironment("MODELS_BASE_URL");
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
@CopyWith()
@DataRepository([ModelAdapter])
class Model extends DataModel<Model> {
  Model({
    // this.id,
    required this.mid,
    required this.name,
    this.description,
    required this.isTemplate,
    this.layers,
  });

  // @override
  // @JsonKey(name: '_id')
  // final String? id;
  final String mid;
  late String name;
  late String? description;
  late bool isTemplate;
  late List<Layer>? layers;

  @override
  Object? get id => mid;

  Layer findLayer(String lid) {
    return layers!.firstWhere((l) => l.id == lid);
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

  void moveComponent(
    String movingCid,
    String before,
    String after,
  ) {
    late Component movingComponent;

    // Remove the moving component
    if (before.isNotEmpty || after.isNotEmpty) {
      for (var l in layers!) {
        for (var s in l.sections!) {
          try {
            movingComponent =
                s.components!.firstWhere((c) => c.id == movingCid);
            s.components!.removeWhere((c) => c.id == movingCid);
            // ignore: empty_catches
          } catch (e) {}
        }
      }

      for (var l in layers!) {
        for (var s in l.sections!) {
          final targetComponentIdx = s.components!
              .indexWhere((c) => c.id == (before.isNotEmpty ? before : after));
          if (!targetComponentIdx.isNegative) {
            if (before.isNotEmpty) {
              s.components!.insert(targetComponentIdx, movingComponent);
            } else {
              s.components!.insert(targetComponentIdx + 1, movingComponent);
            }
            ModelApi.saveModel(model: this);
          }
        }
      }
    }
  }

  void moveSection(
    String movingSid,
    String before,
    String after,
  ) {
    late Section movingSection;

    // Remove the moving component
    if (before.isNotEmpty || after.isNotEmpty) {
      for (var l in layers!) {
        try {
          movingSection = l.sections!.firstWhere((c) => c.id == movingSid);
          l.sections!.removeWhere((c) => c.id == movingSid);
          // ignore: empty_catches
        } catch (e) {}
      }

      for (var l in layers!) {
        final targetIdx = l.sections!
            .indexWhere((s) => s.id == (before.isNotEmpty ? before : after));
        if (!targetIdx.isNegative) {
          if (before.isNotEmpty) {
            l.sections!.insert(targetIdx, movingSection);
          } else {
            l.sections!.insert(targetIdx + 1, movingSection);
          }
          ModelApi.saveModel(model: this);
        }
      }
    }
  }

  void moveLayer(
    String movingLid,
    String before,
    String after,
  ) {
    late Layer movingLayer;

    if (before.isNotEmpty || after.isNotEmpty) {
      try {
        movingLayer = layers!.firstWhere((l) => l.id == movingLid);
        layers!.removeWhere((c) => c.id == movingLid);
        // ignore: empty_catches
      } catch (e) {}

      final targetIdx = layers!
          .indexWhere((l) => l.id == (before.isNotEmpty ? before : after));
      if (!targetIdx.isNegative) {
        if (before.isNotEmpty) {
          layers!.insert(targetIdx, movingLayer);
        } else {
          layers!.insert(targetIdx + 1, movingLayer);
        }
        ModelApi.saveModel(model: this);
      }
    }
  }
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Layer {
  Layer({
    required this.id,
    required this.name,
    this.description,
  });

  final String id;
  late String name;
  late String? description;
  late List<Section>? sections;

  Section findSection(String sid) {
    return sections!.firstWhere((s) => s.id == sid);
  }

  // ignore: sort_constructors_first
  factory Layer.fromJson(Map<String, dynamic> json) => _$LayerFromJson(json);

  Map<String, dynamic> toJson() => _$LayerToJson(this);
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Section {
  Section({
    required this.id,
    required this.name,
    this.description,
  });

  final String id;
  late String name;
  late String? description;
  late List<Component>? components;

  Component findComponent(String cid) {
    return components!.firstWhere((c) => c.id == cid);
  }

  // ignore: sort_constructors_first
  factory Section.fromJson(Map<String, dynamic> json) =>
      _$SectionFromJson(json);

  Map<String, dynamic> toJson() => _$SectionToJson(this);
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Component {
  Component({
    required this.id,
    required this.name,
    this.description = "",
    this.strategic = 0,
    this.relationship = 0,
    this.notes = "",
  });

  final String id;
  late String name;
  late String description;
  late int strategic;
  late int relationship;
  late String notes;

  // ignore: sort_constructors_first
  factory Component.fromJson(Map<String, dynamic> json) =>
      _$ComponentFromJson(json);

  Map<String, dynamic> toJson() => _$ComponentToJson(this);
}
