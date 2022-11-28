// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/component_business_model.dart';
import '../providers/drag_target_provider.dart';

typedef MoveObjectFunction = void Function(String, String, String);

class VerticalDoubleDropZone extends ConsumerWidget {
  const VerticalDoubleDropZone({
    this.direction = Axis.vertical,
    required this.indicatorWidth,
    this.indicatorColor = Colors.black,
    required this.id,
    required this.type,
    required this.model,
    required this.onDrop,
    required this.child,
    super.key,
  });

  final Axis direction;
  final double indicatorWidth;
  final Color indicatorColor;
  final Model model;
  final String id;
  final String type;
  final MoveObjectFunction onDrop;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final targetState = ref.watch(dragTargetProvider(id));

    return DragTarget<Map<String, String>>(
      onWillAccept: (data) {
        return data!["type"]! == type && data["id"]! != id;
      },
      onAcceptWithDetails: (details) {
        final side = ref.read(dragTargetProvider(id));
        if (side != DragTargetSide.none && details.data["type"]! == type) {
          onDrop.call(
            details.data["id"]!,
            side == DragTargetSide.top ? id : "",
            side == DragTargetSide.bottom ? id : "",
          );
          ref.read(dragTargetProvider(id).notifier).none();
        }
      },
      onMove: (details) {
        if (details.data["type"] == type && details.data["id"]! != id) {
          final box = context.findRenderObject() as RenderBox;
          final localPos = box.globalToLocal(details.offset);

          if (localPos.dy.isNegative) {
            ref.read(dragTargetProvider(id).notifier).top();
          } else {
            ref.read(dragTargetProvider(id).notifier).bottom();
          }
        }
      },
      onLeave: (data) => ref.read(dragTargetProvider(id).notifier).none(),
      builder: (context, candidateItems, rejectItems) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: indicatorWidth,
              width: MediaQuery.of(context).size.width,
              child: Divider(
                height: indicatorWidth,
                thickness: indicatorWidth,
                color: targetState == DragTargetSide.top
                    ? Colors.blue
                    : Colors.transparent,
              ),
            ),
            LongPressDraggable(
              data: {
                "type": type,
                "id": id,
              },
              feedback: child,
              child: child,
            ),
            SizedBox(
              height: indicatorWidth,
              width: MediaQuery.of(context).size.width,
              child: Divider(
                height: indicatorWidth,
                thickness: indicatorWidth,
                color: targetState == DragTargetSide.bottom
                    ? Colors.blue
                    : Colors.transparent,
              ),
            ),
          ],
        );
      },
    );
  }
}
