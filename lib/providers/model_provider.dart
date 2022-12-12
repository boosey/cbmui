import 'package:cbmui/main.data.dart';
import 'package:flutter_data/flutter_data.dart';
import '../models/component_business_model.dart';

final modelProvider = Provider.family<Model, String>((ref, mid) {
  final dataState = ref.models.watchAll(syncLocal: true);

  return dataState.hasModel
      ? dataState.model!.firstWhere((m) => m.id == mid)
      : Model(
          id: "",
          name: "",
        );
});
