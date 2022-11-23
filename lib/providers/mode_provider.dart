import 'package:flutter_data/flutter_data.dart';

enum Mode {
  edit,
  view,
  analyze,
  delete,
  move,
}

class ModeNotifier extends StateNotifier<Mode> {
  ModeNotifier(super.state);

  void edit() => state = Mode.edit;
  void delete() => state = Mode.delete;
  void move() => state = Mode.move;
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

final isModelViewerDeleteModeProvider =
    Provider((ref) => ref.watch(modelViewerModeProvider) == Mode.analyze);

final isModelViewerMoveModeProvider =
    Provider((ref) => ref.watch(modelViewerModeProvider) == Mode.analyze);

final isModelListEditModeProvider = Provider((ref) => true);
