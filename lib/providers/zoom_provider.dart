// import 'package:cbmui/providers/mode_provider.dart';
// import 'package:cbmui/providers/model_provider.dart';
// import 'package:cbmui/providers/model_viewer_settings.dart';
// import 'package:cbmui/util.dart';
// import 'package:flutter_data/flutter_data.dart';

// class ZoomFactorNotifier extends StateNotifier<double> {
//   ZoomFactorNotifier(super.state);

//   void zoomIn({double zoomFactorDelta = 0.10}) =>
//       state = state + zoomFactorDelta;
//   void zoomOut({double zoomFactorDelta = 0.10}) =>
//       state = state - zoomFactorDelta;
// }

// final zoomFactorProvider = StateNotifierProvider<ZoomFactorNotifier, double>(
//     (_) => ZoomFactorNotifier(1));

// final totalWidthProvider = Provider.family<double, String>((ref, String mid) {
//   final zoomFactor = ref.watch(zoomFactorProvider);
//   final model = ref.watch(modelProvider(mid));
//   final settings = ref.watch(modelViewerSettingsProvider);
//   final isEditMode = ref.watch(isModelViewerEditModeProvider);

//   return getTotalWidth(model, settings, isEditMode) * zoomFactor;
// });
