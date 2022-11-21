import 'package:flutter_data/flutter_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

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
