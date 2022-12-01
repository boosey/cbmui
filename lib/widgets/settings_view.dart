import 'package:cbmui/providers/view_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsViewer extends ConsumerWidget {
  const SettingsViewer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(viewSettingsProvider);
    final notifier = ref.read(viewSettingsProvider.notifier);

    return Card(
      child: SingleChildScrollView(
        child: SizedBox(
          width: 1000,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text("Settings"),
                  ),
                  IconButton(
                    onPressed: () => notifier.hideSettingsView(),
                    icon: const Icon(Icons.close_outlined),
                  ),
                ],
              ),
              Card(
                child: Column(
                  children: [
                    const Text("Component"),
                    SettingsSlider(
                      label: "Component Size",
                      value: () => settings.componentLabelWidth,
                      onChanged: (v) {
                        notifier.updateSettings(
                          settings.copyWith(componentLabelWidth: v.toDouble()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsSlider extends StatelessWidget {
  const SettingsSlider({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final num Function() value;
  final Function(num) onChanged;

  @override
  Widget build(BuildContext context) {
    final v = value.call();
    return Stack(
      children: [
        Text(label),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              v.toString(),
              textAlign: TextAlign.center,
            ),
            Slider(
              value: v.toDouble(),
              min: 50,
              max: 300,
              divisions: 50,
              onChanged: (newV) => onChanged.call(newV),
            ),
          ],
        ),
      ],
    );
  }
}
