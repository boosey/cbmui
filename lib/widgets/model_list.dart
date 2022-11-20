import 'package:cbmui/providers/current_model_provider.dart';
import 'package:cbmui/widgets/model_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/component_business_model.dart';
import 'model_viewer.dart';

class ModelList extends ConsumerWidget {
  const ModelList({Key? key, required this.models}) : super(key: key);

  final List<Model> models;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              onPressed: () {},
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
                  (m) => SizedBox(
                    width: 350,
                    height: 350,
                    child: GestureDetector(
                      onTap: () {
                        ref
                            .read(currentModelProvider.notifier)
                            .setCurrentModel(m);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ModelViewer(mid: m.mid)),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Card(
                          elevation: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: ModelThumbnail(
                                    model: m,
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
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
