// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'layer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Layer _$$_LayerFromJson(Map<String, dynamic> json) => _$_Layer(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String? ?? "",
      sections: (json['sections'] as List<dynamic>?)
              ?.map((e) => Section.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_LayerToJson(_$_Layer instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'sections': instance.sections.map((e) => e.toJson()).toList(),
    };
