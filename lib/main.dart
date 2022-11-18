import 'package:cbmui/models/component_business_model.dart';
import 'package:cbmui/util.dart';
import 'package:cbmui/widgets/model_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'main.data.dart';

void main() {
  runApp(
    ProviderScope(
      // TODO: Remove hack to make flutter data not crash
      overrides: [configureRepositoryLocalStorage(clear: true)],
      child: const ComponentBusinessModelsApp(),
    ),
  );
}

class ComponentBusinessModelsApp extends ConsumerWidget {
  const ComponentBusinessModelsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ModelApi.setRepository(ref.read(modelsRepositoryProvider));

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ref.watch(repositoryInitializerProvider).when(
                error: (error, _) => Text(error.toString()),
                loading: () => const CircularProgressIndicator(),
                data: (_) {
                  final state = ref.models.watchAll(syncLocal: true);
                  if (state.isLoading || !state.hasModel) {
                    return const CircularProgressIndicator();
                  } else {
                    return Container(
                      constraints: const BoxConstraints.expand(),
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: ModelViewer(model: state.model!.first),
                      ),
                    );
                  }
                },
              ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
