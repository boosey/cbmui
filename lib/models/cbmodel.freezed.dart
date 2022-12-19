// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cbmodel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CBModel _$CBModelFromJson(Map<String, dynamic> json) {
  return _CBModel.fromJson(json);
}

/// @nodoc
mixin _$CBModel {
  String get id => throw _privateConstructorUsedError;
  set id(String value) => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  set name(String value) => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  set description(String value) => throw _privateConstructorUsedError;
  List<Layer> get layers => throw _privateConstructorUsedError;
  set layers(List<Layer> value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CBModelCopyWith<CBModel> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CBModelCopyWith<$Res> {
  factory $CBModelCopyWith(CBModel value, $Res Function(CBModel) then) =
      _$CBModelCopyWithImpl<$Res, CBModel>;
  @useResult
  $Res call({String id, String name, String description, List<Layer> layers});
}

/// @nodoc
class _$CBModelCopyWithImpl<$Res, $Val extends CBModel>
    implements $CBModelCopyWith<$Res> {
  _$CBModelCopyWithImpl(this._value, this._then);

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
    Object? layers = null,
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
      layers: null == layers
          ? _value.layers
          : layers // ignore: cast_nullable_to_non_nullable
              as List<Layer>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CBModelCopyWith<$Res> implements $CBModelCopyWith<$Res> {
  factory _$$_CBModelCopyWith(
          _$_CBModel value, $Res Function(_$_CBModel) then) =
      __$$_CBModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String description, List<Layer> layers});
}

/// @nodoc
class __$$_CBModelCopyWithImpl<$Res>
    extends _$CBModelCopyWithImpl<$Res, _$_CBModel>
    implements _$$_CBModelCopyWith<$Res> {
  __$$_CBModelCopyWithImpl(_$_CBModel _value, $Res Function(_$_CBModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? layers = null,
  }) {
    return _then(_$_CBModel(
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
      layers: null == layers
          ? _value.layers
          : layers // ignore: cast_nullable_to_non_nullable
              as List<Layer>,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class _$_CBModel extends _CBModel {
  _$_CBModel(
      {required this.id,
      required this.name,
      this.description = "",
      this.layers = const []})
      : super._();

  factory _$_CBModel.fromJson(Map<String, dynamic> json) =>
      _$$_CBModelFromJson(json);

  @override
  String id;
  @override
  String name;
  @override
  @JsonKey()
  String description;
  @override
  @JsonKey()
  List<Layer> layers;

  @override
  String toString() {
    return 'CBModel(id: $id, name: $name, description: $description, layers: $layers)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CBModelCopyWith<_$_CBModel> get copyWith =>
      __$$_CBModelCopyWithImpl<_$_CBModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CBModelToJson(
      this,
    );
  }
}

abstract class _CBModel extends CBModel {
  factory _CBModel(
      {required String id,
      required String name,
      String description,
      List<Layer> layers}) = _$_CBModel;
  _CBModel._() : super._();

  factory _CBModel.fromJson(Map<String, dynamic> json) = _$_CBModel.fromJson;

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
  List<Layer> get layers;
  set layers(List<Layer> value);
  @override
  @JsonKey(ignore: true)
  _$$_CBModelCopyWith<_$_CBModel> get copyWith =>
      throw _privateConstructorUsedError;
}
