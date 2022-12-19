import 'package:cbmui/providers/model_list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/cbmodel.dart';

final modelProvider = Provider.family<CBModel, String>((ref, mid) {
  final models = ref.watch(modelListProvider);

  return models.firstWhere((m) => m.id == mid);
});
