import 'package:cbmui/providers/mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditButtons extends ConsumerWidget {
  const EditButtons({
    super.key,
    this.padding = const EdgeInsets.only(bottom: 5),
    this.onCopy,
    this.onDelete,
  });

  final EdgeInsets padding;
  final void Function()? onDelete;
  final void Function()? onCopy;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditMode = ref.watch(isModelViewerEditModeProvider);
    return Visibility(
      visible: isEditMode,
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            InkResponse(
              onTap: onDelete ?? () {},
              child: const Icon(
                Icons.delete_outlined,
                size: 20,
              ),
            ),
            InkResponse(
              onTap: onCopy ?? () {},
              child: const Icon(
                Icons.copy_outlined,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
