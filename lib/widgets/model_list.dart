import 'package:cbmui/providers/view_settings.dart';
import 'package:cbmui/api/model_api.dart';
import 'package:cbmui/widgets/model_thumbnail.dart';
import 'package:cbmui/widgets/model_viewer.dart';
import 'package:cbmui/widgets/settings_view.dart';
import 'package:cbmui/widgets/thumbnail_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/cbmodel.dart';

class ModelList extends ConsumerWidget {
  const ModelList({Key? key, required this.models}) : super(key: key);

  final List<CBModel> models;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(viewSettingsProvider);
    final notifer = ref.watch(viewSettingsProvider.notifier);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add_box),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Model",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(
                right: 20,
              ),
              child: IconButton(
                onPressed: () => notifer.showSettingsView(),
                icon: const Icon(Icons.settings_outlined),
              ),
            ),
          ],
        ),
        Expanded(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Wrap(
                  children: [
                    ...models.map(
                      (m) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ModelViewer(mid: m.id)),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500),
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
              Visibility(
                visible: settings.showSettingsView,
                child: const Center(child: SettingsViewer()),
              ),
            ],
          ),
        )
      ],
    );
  }
}
