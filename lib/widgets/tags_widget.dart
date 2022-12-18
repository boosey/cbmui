import 'package:cbmui/api/model_api.dart';
import 'package:cbmui/providers/tags_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_tag_editor/tag_editor.dart';

import '../models/component_business_model.dart';

class ComponentTags extends ConsumerWidget {
  const ComponentTags(
      {super.key, required this.component, required this.model});

  final Component component;
  final Model model;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allTags = ref.watch(tagsProvider);
    final notifier = ref.read(tagsProvider.notifier);

    return TagEditor(
        length: component.tags.length,
        delimiters: const [',', ' '],
        hasAddButton: true,
        resetTextOnSubmitted: true,
        inputDecoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Hint Text...',
        ),
        onSubmitted: (newValue) async =>
            selectNewValue(newValue, allTags, notifier),
        onTagChanged: (newValue) async =>
            selectNewValue(newValue, allTags, notifier),
        tagBuilder: (context, index) => _Chip(
              index: index,
              label: component.tags.elementAt(index),
              onDeleted: onDelete,
            ),
        suggestionBuilder: (context, state, data) => ListTile(
              key: ObjectKey(data),
              title: Text(data),
              onTap: () {
                selectNewValue(data, allTags, notifier);
                state.selectSuggestion(data);
              },
            ),
        suggestionsBoxElevation: 10,
        findSuggestions: (String query) {
          final suggestions = allTags.where((t) => t.contains(query)).toList();
          suggestions.add(query);
          return suggestions;
        });
  }

  void selectNewValue(
      String newValue, List<String> allTags, TagsNotifier notifier) async {
    final t = newValue.trim().toLowerCase();
    if (t.isNotEmpty) {
      if (!allTags.contains(t)) {
        await ModelApi.addTag(t);
        await notifier.reload();
      }

      component.tags.add(t);
      await ModelApi.saveModel(model: model);
    }
  }

  Future<void> onDelete(int index) async {
    component.tags.removeWhere((t) => t == component.tags.elementAt(index));
    await ModelApi.saveModel(model: model);
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.onDeleted,
    required this.index,
  });

  final String label;
  final ValueChanged<int> onDeleted;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: const EdgeInsets.only(left: 8.0),
      label: Text(label),
      deleteIcon: const Icon(
        Icons.close,
        size: 18,
      ),
      onDeleted: () {
        onDeleted(index);
      },
    );
  }
}
