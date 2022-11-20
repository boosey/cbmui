import 'package:flutter_data/flutter_data.dart';

import '../models/component_business_model.dart';

class CurrentModelNotifier extends StateNotifier<Model> {
  CurrentModelNotifier(super.state);

  void setCurrentModel(Model model) => state = model;
}

final currentModelProvider = StateNotifierProvider<CurrentModelNotifier, Model>(
    (_) => CurrentModelNotifier(Model(mid: "", name: "", isTemplate: false)));
