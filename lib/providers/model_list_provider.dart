import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/model_api.dart';
import '../models/cbmodel.dart';

class ModelListNotifier extends StateNotifier<List<CBModel>> {
  ModelListNotifier(super.state) {
    Timer(const Duration(milliseconds: 500), () => refresh());
  }

  Future<void> refresh() async => state = await ModelApi.getModels();
}

final modelListProvider =
    StateNotifierProvider<ModelListNotifier, List<CBModel>>((ref) {
  ModelApi.ref = ref;
  return ModelListNotifier([]);
});
