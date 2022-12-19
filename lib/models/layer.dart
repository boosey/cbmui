import 'package:cbmui/models/section.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'layer.freezed.dart';
part 'layer.g.dart';

@unfreezed
class Layer with _$Layer {
  // ignore: invalid_annotation_target
  @JsonSerializable(includeIfNull: false, explicitToJson: true)
  factory Layer({
    required String id,
    required String name,
    @Default("") String description,
    @Default([]) List<Section> sections,
  }) = _Layer;

  const Layer._();

  factory Layer.fromJson(Map<String, dynamic> json) => _$LayerFromJson(json);

  Section findSection(String sid) {
    return sections.firstWhere((s) => s.id == sid);
  }
}
