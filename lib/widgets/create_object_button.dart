import 'package:cbmui/providers/mode_provider.dart';
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

    return Visibility(
      visible: isVisible,
      child: Padding(
        padding: const EdgeInsets.all(8),
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
