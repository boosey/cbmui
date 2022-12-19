import 'package:freezed_annotation/freezed_annotation.dart';

import 'component.dart';

part 'section.freezed.dart';
part 'section.g.dart';

@unfreezed
class Section with _$Section {
  // ignore: invalid_annotation_target
  @JsonSerializable(includeIfNull: false, explicitToJson: true)
  factory Section({
    required String id,
    required String name,
    @Default("") String description,
    @Default([]) List<Component> components,
  }) = _Section;

  const Section._();

  factory Section.fromJson(Map<String, dynamic> json) =>
      _$SectionFromJson(json);
}
