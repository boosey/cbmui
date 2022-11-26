// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/component_business_model.dart';
import '../providers/component_drag_target_provider.dart';

class HorizontalDoubleDropZone extends ConsumerWidget {
  const HorizontalDoubleDropZone({
    this.direction = Axis.horizontal,
    required this.indicatorWidth,
    this.indicatorColor = Colors.black,
    required this.cid,
    required this.model,
    required this.onDrop,
    required this.child,
    super.key,
  });

  final Axis direction;
  final double indicatorWidth;
  final Color indicatorColor;
  final Model model;
  final String cid;
  final Function onDrop;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final targetState = ref.watch(componentDragTargetProvider(cid));

    return DragTarget<Map<String, String>>(
      onWillAccept: (data) {
        return data!["type"]! == "component" && data["cid"]! != cid;
      },
      onAcceptWithDetails: (details) {
        final side = ref.read(componentDragTargetProvider(cid));
        if (side != ComponentDragTarget.none &&
            details.data["type"]! == "component") {
          model.moveComponent(
            details.data["cid"]!,
            before: side == ComponentDragTarget.left ? cid : "",
            after: side == ComponentDragTarget.right ? cid : "",
          );
          ref.read(componentDragTargetProvider(cid).notifier).none();
        }
      },
      onMove: (details) {
        if (details.data["type"] == "component" &&
            details.data["cid"]! != cid) {
          final box = context.findRenderObject() as RenderBox;
          final localPos = box.globalToLocal(details.offset);
          if (localPos.dx.isNegative) {
            ref.read(componentDragTargetProvider(cid).notifier).left();
          } else {
            ref.read(componentDragTargetProvider(cid).notifier).right();
          }
        }
      },
      onLeave: (data) =>
          ref.read(componentDragTargetProvider(cid).notifier).none(),
      builder: (context, candidateItems, rejectItems) => Stack(
        children: [
          Positioned.fill(
            child: Container(
              alignment: Alignment.centerLeft,
              // This child will fill full height, replace it with your leading widget
              child: Container(
                color: targetState == ComponentDragTarget.left
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
                  "type": "component",
                  "cid": cid,
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
                color: targetState == ComponentDragTarget.right
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
