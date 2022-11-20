import 'package:cbmui/providers/mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateButton extends ConsumerWidget {
  const CreateButton({
    Key? key,
    required this.onChanged,
    this.topSpacerPointSize = 0,
  }) : super(key: key);

  final void Function() onChanged;
  final double topSpacerPointSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVisible = ref.watch(isModelViewerEditModeProvider);

    return Visibility(
      visible: isVisible,
      child: Column(
        children: [
          topSpacerPointSize > 0
              ? Text(
                  "",
                  style: TextStyle(fontSize: topSpacerPointSize),
                )
              : const SizedBox(
                  width: 0,
                  height: 0,
                ),
          IconButton(
            icon: const Icon(Icons.add_box),
            color: Colors.blue,
            onPressed: onChanged,
          ),
        ],
      ),
    );
  }
}
