// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/cbmodel.dart';
import '../providers/drag_target_provider.dart';

typedef MoveObjectFunction = void Function(String, String, String);

class HorizontalDoubleDropZone extends ConsumerWidget {
  const HorizontalDoubleDropZone({
    this.direction = Axis.horizontal,
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
  final CBModel model;
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
          // model.moveComponent(
          //   details.data["id"]!,
          //   before: side == dragTargetSide.left ? id : "",
          //   after: side == dragTargetSide.right ? id : "",
          // );
          onDrop.call(
            details.data["id"]!,
            side == DragTargetSide.left ? id : "",
            side == DragTargetSide.right ? id : "",
          );
          ref.read(dragTargetProvider(id).notifier).none();
        }
      },
      onMove: (details) {
        if (details.data["type"] == type && details.data["id"]! != id) {
          final box = context.findRenderObject() as RenderBox;
          final localPos = box.globalToLocal(details.offset);
          if (localPos.dx.isNegative) {
            ref.read(dragTargetProvider(id).notifier).left();
          } else {
            ref.read(dragTargetProvider(id).notifier).right();
          }
        }
      },
      onLeave: (data) => ref.read(dragTargetProvider(id).notifier).none(),
      builder: (context, candidateItems, rejectItems) => Stack(
        children: [
          Positioned.fill(
            child: Container(
              alignment: Alignment.centerLeft,
              // This child will fill full height, replace it with your leading widget
              child: Container(
                color: targetState == DragTargetSide.left
                    ? Colors.blue
                    : Colors.transparent,
                width: indicatorWidth,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: indicatorWidth,
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
                width: indicatorWidth,
              ),
            ],
          ),
          Positioned.fill(
            child: Container(
              alignment: Alignment.centerRight,
              // This child will fill full height, replace it with your leading widget
              child: Container(
                color: targetState == DragTargetSide.right
                    ? Colors.blue
                    : Colors.transparent,
                width: indicatorWidth,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
