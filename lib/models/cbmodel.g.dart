// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'cbmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CBModel _$$_CBModelFromJson(Map<String, dynamic> json) => _$_CBModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String? ?? "",
      layers: (json['layers'] as List<dynamic>?)
              ?.map((e) => Layer.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_CBModelToJson(_$_CBModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'layers': instance.layers.map((e) => e.toJson()).toList(),
    };
