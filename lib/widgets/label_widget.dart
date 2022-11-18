import 'package:cbmui/providers/mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LabelWidget extends ConsumerStatefulWidget {
  const LabelWidget({
    Key? key,
    required this.label,
    this.fontSize = 32,
    this.fontWeight = FontWeight.bold,
    this.width = 500,
    this.readonly = false,
    this.alignment = TextAlign.start,
    this.onChanged,
  }) : super(key: key);

  final double fontSize;
  final FontWeight fontWeight;
  final String label;
  final double width;
  final bool readonly;
  final TextAlign alignment;
  final void Function(String)? onChanged;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _LabelWidgetState();
  }
}

class _LabelWidgetState extends ConsumerState<LabelWidget> {
  late TextEditingController labelController;
  late TextStyle style;

  @override
  void initState() {
    super.initState();
    labelController = TextEditingController(text: widget.label);
    style = TextStyle(
      fontSize: widget.fontSize,
      fontWeight: widget.fontWeight,
    );
  }

  @override
  void dispose() {
    labelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditMode = ref.watch(isEditModeProvider);

    return isEditMode && !widget.readonly
        ? SizedBox(
            width: widget.width,
            child: TextField(
              controller: labelController,
              style: style,
              textAlign: widget.alignment,
              onSubmitted: widget.onChanged,
            ),
          )
        : Text(
            widget.label,
            style: style,
            textAlign: widget.alignment,
          );
  }
}
