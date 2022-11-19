// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'component_business_model.dart';

// **************************************************************************
// RepositoryGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, duplicate_ignore

mixin $ModelLocalAdapter on LocalAdapter<Model> {
  static final Map<String, RelationshipMeta> _kModelRelationshipMetas = {};

  @override
  Map<String, RelationshipMeta> get relationshipMetas =>
      _kModelRelationshipMetas;

  @override
  Model deserialize(map) {
    map = transformDeserialize(map);
    return _$ModelFromJson(map);
  }

  @override
  Map<String, dynamic> serialize(model, {bool withRelationships = true}) {
    final map = _$ModelToJson(model);
    return transformSerialize(map, withRelationships: withRelationships);
  }
}

final _modelsFinders = <String, dynamic>{};

// ignore: must_be_immutable
class $ModelHiveLocalAdapter = HiveLocalAdapter<Model> with $ModelLocalAdapter;

class $ModelRemoteAdapter = RemoteAdapter<Model> with ModelAdapter;

final internalModelsRemoteAdapterProvider = Provider<RemoteAdapter<Model>>(
    (ref) => $ModelRemoteAdapter($ModelHiveLocalAdapter(ref.read, typeId: null),
        InternalHolder(_modelsFinders)));

final modelsRepositoryProvider =
    Provider<Repository<Model>>((ref) => Repository<Model>(ref.read));

extension ModelDataRepositoryX on Repository<Model> {
  ModelAdapter get modelAdapter => remoteAdapter as ModelAdapter;
}

extension ModelRelationshipGraphNodeX on RelationshipGraphNode<Model> {}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Model _$ModelFromJson(Map<String, dynamic> json) => Model(
      mid: json['mid'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      isTemplate: json['isTemplate'] as bool,
      layers: (json['layers'] as List<dynamic>?)
          ?.map((e) => Layer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ModelToJson(Model instance) {
  final val = <String, dynamic>{
    'mid': instance.mid,
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('description', instance.description);
  val['isTemplate'] = instance.isTemplate;
  writeNotNull('layers', instance.layers?.map((e) => e.toJson()).toList());
  return val;
}

Layer _$LayerFromJson(Map<String, dynamic> json) => Layer(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
    )..sections = (json['sections'] as List<dynamic>?)
        ?.map((e) => Section.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$LayerToJson(Layer instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('description', instance.description);
  writeNotNull('sections', instance.sections?.map((e) => e.toJson()).toList());
  return val;
}

Section _$SectionFromJson(Map<String, dynamic> json) => Section(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
    )..components = (json['components'] as List<dynamic>?)
        ?.map((e) => Component.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$SectionToJson(Section instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('description', instance.description);
  writeNotNull(
      'components', instance.components?.map((e) => e.toJson()).toList());
  return val;
}

Component _$ComponentFromJson(Map<String, dynamic> json) => Component(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String? ?? "",
      strategic: json['strategic'] as int? ?? 0,
      relationship: json['relationship'] as int? ?? 0,
      notes: json['notes'] as String? ?? "",
    );

Map<String, dynamic> _$ComponentToJson(Component instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'strategic': instance.strategic,
      'relationship': instance.relationship,
      'notes': instance.notes,
    };
