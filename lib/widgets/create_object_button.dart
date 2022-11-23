import 'package:cbmui/providers/mode_provider.dart';
import 'package:cbmui/providers/model_viewer_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateButton extends ConsumerWidget {
  const CreateButton({
    Key? key,
    required this.onChanged,
    this.shiftDown = false,
  }) : super(key: key);

  final void Function() onChanged;
  final bool shiftDown;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVisible = ref.watch(isModelViewerEditModeProvider);
    final settings = ref.watch(modelViewerSettingsProvider);

    return Visibility(
      visible: isVisible,
      child: Column(
        children: [
          shiftDown
              ? Text(
                  "",
                  style: TextStyle(fontSize: settings.sectionLabelFontSize),
                )
              : const SizedBox(
                  width: 0,
                  height: 0,
                ),
          IconButton(
            icon: const Icon(Icons.add_box),
            color: Colors.blue,
            onPressed: () => onChanged.call(),
          ),
        ],
      ),
    );
  }
}
