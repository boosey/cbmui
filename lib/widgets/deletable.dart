import 'package:cbmui/providers/mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Deletable extends ConsumerWidget {
  const Deletable({
    Key? key,
    required this.child,
    required this.onDeleteRequested,
    this.modeProvider,
  }) : super(key: key);

  final Widget child;
  final void Function() onDeleteRequested;
  final Provider? modeProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditMode = ref.watch(modeProvider ?? isModelViewerEditModeProvider);

    return Stack(
      children: [
        child,
        Visibility(
          visible: isEditMode,
          child: IconButton(
            icon: const Icon(Icons.close),
            onPressed: onDeleteRequested,
          ),
        ),
      ],
    );
  }
}
