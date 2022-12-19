// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'layer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Layer _$LayerFromJson(Map<String, dynamic> json) {
  return _Layer.fromJson(json);
}

/// @nodoc
mixin _$Layer {
  String get id => throw _privateConstructorUsedError;
  set id(String value) => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  set name(String value) => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  set description(String value) => throw _privateConstructorUsedError;
  List<Section> get sections => throw _privateConstructorUsedError;
  set sections(List<Section> value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LayerCopyWith<Layer> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LayerCopyWith<$Res> {
  factory $LayerCopyWith(Layer value, $Res Function(Layer) then) =
      _$LayerCopyWithImpl<$Res, Layer>;
  @useResult
  $Res call(
      {String id, String name, String description, List<Section> sections});
}

/// @nodoc
class _$LayerCopyWithImpl<$Res, $Val extends Layer>
    implements $LayerCopyWith<$Res> {
  _$LayerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? sections = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      sections: null == sections
          ? _value.sections
          : sections // ignore: cast_nullable_to_non_nullable
              as List<Section>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LayerCopyWith<$Res> implements $LayerCopyWith<$Res> {
  factory _$$_LayerCopyWith(_$_Layer value, $Res Function(_$_Layer) then) =
      __$$_LayerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, String name, String description, List<Section> sections});
}

/// @nodoc
class __$$_LayerCopyWithImpl<$Res> extends _$LayerCopyWithImpl<$Res, _$_Layer>
    implements _$$_LayerCopyWith<$Res> {
  __$$_LayerCopyWithImpl(_$_Layer _value, $Res Function(_$_Layer) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? sections = null,
  }) {
    return _then(_$_Layer(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      sections: null == sections
          ? _value.sections
          : sections // ignore: cast_nullable_to_non_nullable
              as List<Section>,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class _$_Layer extends _Layer {
  _$_Layer(
      {required this.id,
      required this.name,
      this.description = "",
      this.sections = const []})
      : super._();

  factory _$_Layer.fromJson(Map<String, dynamic> json) =>
      _$$_LayerFromJson(json);

  @override
  String id;
  @override
  String name;
  @override
  @JsonKey()
  String description;
  @override
  @JsonKey()
  List<Section> sections;

  @override
  String toString() {
    return 'Layer(id: $id, name: $name, description: $description, sections: $sections)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LayerCopyWith<_$_Layer> get copyWith =>
      __$$_LayerCopyWithImpl<_$_Layer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LayerToJson(
      this,
    );
  }
}

abstract class _Layer extends Layer {
  factory _Layer(
      {required String id,
      required String name,
      String description,
      List<Section> sections}) = _$_Layer;
  _Layer._() : super._();

  factory _Layer.fromJson(Map<String, dynamic> json) = _$_Layer.fromJson;

  @override
  String get id;
  set id(String value);
  @override
  String get name;
  set name(String value);
  @override
  String get description;
  set description(String value);
  @override
  List<Section> get sections;
  set sections(List<Section> value);
  @override
  @JsonKey(ignore: true)
  _$$_LayerCopyWith<_$_Layer> get copyWith =>
      throw _privateConstructorUsedError;
}
