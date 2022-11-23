// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'component_business_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ModelCWProxy {
  Model description(String? description);

  Model isTemplate(bool isTemplate);

  Model layers(List<Layer>? layers);

  Model mid(String mid);

  Model name(String name);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Model(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Model(...).copyWith(id: 12, name: "My name")
  /// ````
  Model call({
    String? description,
    bool? isTemplate,
    List<Layer>? layers,
    String? mid,
    String? name,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfModel.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfModel.copyWith.fieldName(...)`
class _$ModelCWProxyImpl implements _$ModelCWProxy {
  final Model _value;

  const _$ModelCWProxyImpl(this._value);

  @override
  Model description(String? description) => this(description: description);

  @override
  Model isTemplate(bool isTemplate) => this(isTemplate: isTemplate);

  @override
  Model layers(List<Layer>? layers) => this(layers: layers);

  @override
  Model mid(String mid) => this(mid: mid);

  @override
  Model name(String name) => this(name: name);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Model(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Model(...).copyWith(id: 12, name: "My name")
  /// ````
  Model call({
    Object? description = const $CopyWithPlaceholder(),
    Object? isTemplate = const $CopyWithPlaceholder(),
    Object? layers = const $CopyWithPlaceholder(),
    Object? mid = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
  }) {
    return Model(
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      isTemplate:
          isTemplate == const $CopyWithPlaceholder() || isTemplate == null
              ? _value.isTemplate
              // ignore: cast_nullable_to_non_nullable
              : isTemplate as bool,
      layers: layers == const $CopyWithPlaceholder()
          ? _value.layers
          // ignore: cast_nullable_to_non_nullable
          : layers as List<Layer>?,
      mid: mid == const $CopyWithPlaceholder() || mid == null
          ? _value.mid
          // ignore: cast_nullable_to_non_nullable
          : mid as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
    );
  }
}

extension $ModelCopyWith on Model {
  /// Returns a callable class that can be used as follows: `instanceOfModel.copyWith(...)` or like so:`instanceOfModel.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ModelCWProxy get copyWith => _$ModelCWProxyImpl(this);
}

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
