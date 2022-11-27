import 'dart:async';

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
    this.maxlines = 1,
    this.alignment = TextAlign.center,
    this.onChanged,
  }) : super(key: key);

  final double fontSize;
  final FontWeight fontWeight;
  final String label;
  final double width;
  final int maxlines;
  final TextAlign alignment;
  final void Function(String)? onChanged;

  @override
  ConsumerState<LabelWidget> createState() {
    return _LabelWidgetState();
  }
}

class _LabelWidgetState extends ConsumerState<LabelWidget> {
  late final TextEditingController labelController;
  late final TextStyle style;
  Timer timer = Timer(const Duration(milliseconds: 0), () {});

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
    timer.cancel();
    super.dispose();
  }

  void onChanged(String s) {
    timer.cancel();
    timer = Timer(
      const Duration(milliseconds: 1500),
      () {
        widget.onChanged!.call(s);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEditMode = ref.watch(isModelViewerEditModeProvider);

    return SizedBox(
      width: widget.width,
      child: isEditMode
          ? TextField(
              controller: labelController,
              style: style,
              textAlign: widget.alignment,
              onSubmitted: widget.onChanged,
              onChanged: (s) => onChanged(s),
            )
          : Text(
              widget.label,
              overflow: TextOverflow.ellipsis,
              style: style,
              maxLines: widget.maxlines,
              textAlign: widget.alignment,
            ),
    );
  }
}
