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
  Timer timer = Timer(const Duration(milliseconds: 0), () {});

  @override
  void initState() {
    super.initState();
    labelController = TextEditingController(text: widget.label);
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
              style: TextStyle(
                fontSize: widget.fontSize,
                fontWeight: widget.fontWeight,
              ),
              textAlign: widget.alignment,
              onSubmitted: widget.onChanged,
              onChanged: (s) => onChanged(s),
            )
          : Text(
              widget.label,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: widget.fontSize,
                fontWeight: widget.fontWeight,
              ),
              maxLines: widget.maxlines,
              textAlign: widget.alignment,
            ),
    );
  }
}
