import 'package:cbmui/providers/mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeletableOrMoveable extends ConsumerWidget {
  const DeletableOrMoveable(
      {Key? key,
      required this.child,
      required this.onDeleteRequested,
      this.deleteModeProvider,
      this.moveModeProvider})
      : super(key: key);

  final Widget child;
  final void Function() onDeleteRequested;
  final Provider? deleteModeProvider;
  final Provider? moveModeProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDeleteMode =
        ref.watch(deleteModeProvider ?? isModelViewerDeleteModeProvider);
    final isMoveMode =
        ref.watch(moveModeProvider ?? isModelViewerMoveModeProvider);

    return Stack(
      children: [
        child,
        Visibility(
          visible: isDeleteMode,
          child: IconButton(
            icon: const Icon(Icons.close),
            onPressed: onDeleteRequested,
          ),
        ),
        Visibility(
          visible: isMoveMode,
          child: IconButton(
            icon: const Icon(Icons.double_arrow_outlined),
            onPressed: onDeleteRequested,
          ),
        ),
      ],
    );
  }
}
