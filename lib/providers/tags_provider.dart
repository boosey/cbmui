import 'dart:core';

import 'package:cbmui/api/model_api.dart';
import 'package:flutter_data/flutter_data.dart';

class TagsNotifier extends StateNotifier<List<String>> {
  TagsNotifier(super.state);

  Future<void> reload() async => state = await ModelApi.getTags();
}

final tagsProvider = StateNotifierProvider<TagsNotifier, List<String>>((_) {
  return TagsNotifier([]);
});
