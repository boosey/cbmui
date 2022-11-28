import 'package:cbmui/providers/model_viewer_settings.dart';
import 'package:cbmui/util.dart';
import 'package:cbmui/widgets/model_thumbnail.dart';
import 'package:cbmui/widgets/model_viewer.dart';
import 'package:cbmui/widgets/thimbnail_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/component_business_model.dart';
import '../providers/mode_provider.dart';
import 'deletable.dart';

class ModelList extends ConsumerWidget {
  const ModelList({Key? key, required this.models}) : super(key: key);

  final List<Model> models;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(modelViewerSettingsProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: 250,
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                await ModelApi.createModel();
              },
              child: const Text(
                "Create",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Wrap(
              children: [
                ...models.map(
                  (m) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ModelViewer(mid: m.mid)),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Card(
                        elevation: settings.elevation,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: SizedBox(
                                width: 400,
                                height: 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ThumbnailMenu(model: m),
                                    Expanded(
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: ModelThumbnail(
                                          model: m,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                m.name,
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
