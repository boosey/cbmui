import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Mode {
  edit,
  view,
  analyze,
}

class ModeNotifier extends StateNotifier<Mode> {
  ModeNotifier(super.state);

  void edit() => state = Mode.edit;
  void view() => state = Mode.view;
  void analyze() => state = Mode.analyze;
}

final modelViewerModeProvider =
    StateNotifierProvider<ModeNotifier, Mode>((_) => ModeNotifier(Mode.view));

final isModelViewerEditModeProvider =
    Provider((ref) => ref.watch(modelViewerModeProvider) == Mode.edit);

final isModelViewerViewModeProvider =
    Provider((ref) => ref.watch(modelViewerModeProvider) == Mode.view);

final isModelViewerAnalyzeModeProvider =
    Provider((ref) => ref.watch(modelViewerModeProvider) == Mode.analyze);
