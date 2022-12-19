import 'package:freezed_annotation/freezed_annotation.dart';

part 'component.freezed.dart';
part 'component.g.dart';

@unfreezed
class Component with _$Component {
  // ignore: invalid_annotation_target
  @JsonSerializable(includeIfNull: false, explicitToJson: true)
  factory Component({
    required String id,
    required String name,
    @Default("") String description,
    @Default(0) int strategic,
    @Default(0) int relationship,
    @Default("") String notes,
    @Default(false) bool isIbmTechnology,
    @Default(false) bool isIbmConsulting,
    @Default(false) bool isBusiness,
    @Default(false) bool isAppDev,
    @Default(false) bool isOpsInfra,
    @Default("") String businessContact,
    @Default("") String appDevContact,
    @Default("") String opsInfraContact,
    @Default({}) Set<String> tags,
  }) = _Component;

  const Component._();

  factory Component.fromJson(Map<String, dynamic> json) =>
      _$ComponentFromJson(json);
}
