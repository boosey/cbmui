import 'package:cbmui/providers/mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ModeSelector extends ConsumerWidget {
  const ModeSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(modelViewerModeProvider);
    return ToggleButtons(
      onPressed: (index) {
        switch (index) {
          case 0:
            ref.read(modelViewerModeProvider.notifier).view();
            break;
          case 1:
            ref.read(modelViewerModeProvider.notifier).edit();
            break;
          case 2:
            ref.read(modelViewerModeProvider.notifier).delete();
            break;
          case 3:
            ref.read(modelViewerModeProvider.notifier).move();
            break;
          case 4:
            ref.read(modelViewerModeProvider.notifier).analyze();
            break;
          default:
        }
      },
      isSelected: [
        mode == Mode.view,
        mode == Mode.edit,
        mode == Mode.delete,
        mode == Mode.move,
        mode == Mode.analyze,
      ],
      children: const [
        Icon(Icons.remove_red_eye_outlined),
        Icon(Icons.edit_outlined),
        Icon(Icons.delete_outline),
        Icon(Icons.double_arrow_outlined),
        Icon(Icons.analytics_outlined),
      ],
    );
  }
}
