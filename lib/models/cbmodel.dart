import 'package:cbmui/models/section.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../api/model_api.dart';
import 'component.dart';
import 'layer.dart';
part 'cbmodel.freezed.dart';
part 'cbmodel.g.dart';

@unfreezed
class CBModel with _$CBModel {
  // ignore: invalid_annotation_target
  @JsonSerializable(includeIfNull: false, explicitToJson: true)
  factory CBModel({
    required String id,
    required String name,
    @Default("") String description,
    @Default([]) List<Layer> layers,
  }) = _CBModel;

  const CBModel._();

  factory CBModel.fromJson(Map<String, dynamic> json) =>
      _$CBModelFromJson(json);

  Future<bool> save() async {
    ModelApi.saveCBModel(model: this);
    return true;
  }

  Layer findLayer(String lid) {
    return layers.firstWhere((l) => l.id == lid);
  }

  Component findComponent(String cid, CBModel model) {
    for (var l in model.layers) {
      for (var s in l.sections) {
        for (var c in s.components) {
          if (c.id == cid) {
            return c;
          }
        }
      }
    }
    throw NullThrownError();
  }

  Future<void> deleteLayer(String lid) async {
    layers.removeWhere((l) => l.id == lid);
    await save();
  }

  void moveComponent(
    String movingCid,
    String before,
    String after,
  ) {
    late Component movingComponent;

    // Remove the moving component
    if (before.isNotEmpty || after.isNotEmpty) {
      for (var l in layers) {
        for (var s in l.sections) {
          try {
            movingComponent = s.components.firstWhere((c) => c.id == movingCid);
            s.components.removeWhere((c) => c.id == movingCid);
            // ignore: empty_catches
          } catch (e) {}
        }
      }

      for (var l in layers) {
        for (var s in l.sections) {
          final targetComponentIdx = s.components
              .indexWhere((c) => c.id == (before.isNotEmpty ? before : after));
          if (!targetComponentIdx.isNegative) {
            if (before.isNotEmpty) {
              s.components.insert(targetComponentIdx, movingComponent);
            } else {
              s.components.insert(targetComponentIdx + 1, movingComponent);
            }
            ModelApi.saveCBModel(model: this);
          }
        }
      }
    }
  }

  void moveSection(
    String movingSid,
    String before,
    String after,
  ) {
    late Section movingSection;

    // Remove the moving component
    if (before.isNotEmpty || after.isNotEmpty) {
      for (var l in layers) {
        try {
          movingSection = l.sections.firstWhere((c) => c.id == movingSid);
          l.sections.removeWhere((c) => c.id == movingSid);
          // ignore: empty_catches
        } catch (e) {}
      }

      for (var l in layers) {
        final targetIdx = l.sections
            .indexWhere((s) => s.id == (before.isNotEmpty ? before : after));
        if (!targetIdx.isNegative) {
          if (before.isNotEmpty) {
            l.sections.insert(targetIdx, movingSection);
          } else {
            l.sections.insert(targetIdx + 1, movingSection);
          }
          ModelApi.saveCBModel(model: this);
        }
      }
    }
  }

  void moveLayer(
    String movingLid,
    String before,
    String after,
  ) {
    late Layer movingLayer;

    if (before.isNotEmpty || after.isNotEmpty) {
      try {
        movingLayer = layers.firstWhere((l) => l.id == movingLid);
        layers.removeWhere((c) => c.id == movingLid);
        // ignore: empty_catches
      } catch (e) {}

      final targetIdx = layers
          .indexWhere((l) => l.id == (before.isNotEmpty ? before : after));
      if (!targetIdx.isNegative) {
        if (before.isNotEmpty) {
          layers.insert(targetIdx, movingLayer);
        } else {
          layers.insert(targetIdx + 1, movingLayer);
        }
        ModelApi.saveCBModel(model: this);
      }
    }
  }
}
