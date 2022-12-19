// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'component.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Component _$$_ComponentFromJson(Map<String, dynamic> json) => _$_Component(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String? ?? "",
      strategic: json['strategic'] as int? ?? 0,
      relationship: json['relationship'] as int? ?? 0,
      notes: json['notes'] as String? ?? "",
      isIbmTechnology: json['isIbmTechnology'] as bool? ?? false,
      isIbmConsulting: json['isIbmConsulting'] as bool? ?? false,
      isBusiness: json['isBusiness'] as bool? ?? false,
      isAppDev: json['isAppDev'] as bool? ?? false,
      isOpsInfra: json['isOpsInfra'] as bool? ?? false,
      businessContact: json['businessContact'] as String? ?? "",
      appDevContact: json['appDevContact'] as String? ?? "",
      opsInfraContact: json['opsInfraContact'] as String? ?? "",
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toSet() ??
          const {},
    );

Map<String, dynamic> _$$_ComponentToJson(_$_Component instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'strategic': instance.strategic,
      'relationship': instance.relationship,
      'notes': instance.notes,
      'isIbmTechnology': instance.isIbmTechnology,
      'isIbmConsulting': instance.isIbmConsulting,
      'isBusiness': instance.isBusiness,
      'isAppDev': instance.isAppDev,
      'isOpsInfra': instance.isOpsInfra,
      'businessContact': instance.businessContact,
      'appDevContact': instance.appDevContact,
      'opsInfraContact': instance.opsInfraContact,
      'tags': instance.tags.toList(),
    };
