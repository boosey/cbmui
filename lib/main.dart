import 'package:cbmui/providers/model_list_provider.dart';
import 'package:cbmui/widgets/model_list.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  if (kReleaseMode) {
    await dotenv.load(fileName: "env.production");
  } else {
    await dotenv.load(fileName: "env.development");
  }
  runApp(
    const ProviderScope(
      child: ComponentBusinessModelsApp(),
    ),
  );
}

class ComponentBusinessModelsApp extends ConsumerWidget {
  const ComponentBusinessModelsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final models = ref.watch(modelListProvider);

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            constraints: const BoxConstraints.expand(),
            child: ModelList(models: models),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
