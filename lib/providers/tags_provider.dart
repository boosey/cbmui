import 'dart:async';
import 'dart:core';

import 'package:cbmui/api/model_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TagsNotifier extends StateNotifier<List<String>> {
  TagsNotifier(super.state) {
    Timer(const Duration(milliseconds: 500), () => refresh());
  }

  Future<void> refresh() async => state = await ModelApi.getTags();
}

final tagsProvider = StateNotifierProvider<TagsNotifier, List<String>>((_) {
  return TagsNotifier([]);
});
