import 'package:flutter_data/flutter_data.dart';

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

final modeProvider =
    StateNotifierProvider<ModeNotifier, Mode>((_) => ModeNotifier(Mode.view));

final isEditModeProvider =
    Provider((ref) => ref.watch(modeProvider) == Mode.edit);
