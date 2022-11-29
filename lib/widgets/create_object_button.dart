import 'package:cbmui/providers/mode_provider.dart';
import 'package:cbmui/providers/view_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateButton extends ConsumerWidget {
  const CreateButton({
    Key? key,
    required this.onChanged,
    this.label = "Create",
  }) : super(key: key);

  final void Function() onChanged;
  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVisible = ref.watch(isModelViewerEditModeProvider);
    final settings = ref.watch(viewSettingsProvider);

    return Visibility(
      visible: isVisible,
      child: Padding(
        padding: EdgeInsets.all(settings.componentBorderWidth),
        child: Row(
          children: [
            ElevatedButton(
              onPressed: () => onChanged.call(),
              child: Row(
                children: [
                  const Icon(Icons.add_box),
                  Text(label),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
