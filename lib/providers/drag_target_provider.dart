import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DragTargetSide {
  left,
  right,
  none,
}

class ComponentDragTargetNotifier extends StateNotifier<DragTargetSide> {
  ComponentDragTargetNotifier(super.state);

  void left() => state = DragTargetSide.left;
  void right() => state = DragTargetSide.right;
  void none() => state = DragTargetSide.none;
}

final dragTargetProvider = StateNotifierProviderFamily<
    ComponentDragTargetNotifier, DragTargetSide, String>(
  (ref, cid) => ComponentDragTargetNotifier(DragTargetSide.none),
);
