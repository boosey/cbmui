import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ComponentDragTarget {
  left,
  right,
  none,
}

class ComponentDragTargetNotifier extends StateNotifier<ComponentDragTarget> {
  ComponentDragTargetNotifier(super.state);

  void left() => state = ComponentDragTarget.left;
  void right() => state = ComponentDragTarget.right;
  void none() => state = ComponentDragTarget.none;
}

final componentDragTargetProvider = StateNotifierProviderFamily<
    ComponentDragTargetNotifier, ComponentDragTarget, String>(
  (ref, cid) => ComponentDragTargetNotifier(ComponentDragTarget.none),
);
