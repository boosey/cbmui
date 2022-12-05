import 'package:cbmui/providers/view_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsViewer extends ConsumerWidget {
  const SettingsViewer({Key? key}) : super(key: key);

  static const areaTitleStyle =
      TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  static const nameStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  static const valueStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(viewSettingsProvider);
    final notifier = ref.read(viewSettingsProvider.notifier);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: SizedBox(
            width: 1000,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Settings",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => notifier.hideSettingsView(),
                        icon: const Icon(Icons.close_outlined),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    layerSettings(settings, notifier),
                    sectionSettings(settings, notifier),
                    componentSettings(settings, notifier),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget componentSettings(
    ViewSettings settings,
    ModelViewerSettingsNotifier notifier,
  ) {
    return SettingsArea(
      label: "Components",
      children: [
        SettingsSlider(
          label: "Label Font Size",
          value: () => settings.componentLabelFontSize,
          min: 6,
          max: 36,
          stops: 60,
          onChanged: (v) {
            notifier.updateSettings(
              settings.copyWith(componentLabelFontSize: v.toDouble()),
            );
          },
        ),
        SettingsSlider(
          label: "Size",
          value: () => settings.componentLabelWidth,
          min: 50,
          max: 300,
          stops: 50,
          onChanged: (v) {
            notifier.updateSettings(
              settings.copyWith(componentLabelWidth: v.toDouble()),
            );
          },
        ),
        ColorChanger(
          label: "Unrated Component",
          currentColor: settings.componentColor,
          onChanged: (c) {
            notifier.updateSettings(settings.copyWith(componentColor: c));
          },
        ),
        ColorChanger(
          label: "Rated Component",
          currentColor: settings.componentIsRatedColor,
          onChanged: (c) {
            notifier
                .updateSettings(settings.copyWith(componentIsRatedColor: c));
          },
        )
      ],
    );
  }

  Widget sectionSettings(
      ViewSettings settings, ModelViewerSettingsNotifier notifier) {
    return SettingsArea(
      label: "Sections",
      children: [
        SettingsSlider(
          label: "Label Font Size",
          value: () => settings.sectionLabelFontSize,
          min: 6,
          max: 36,
          stops: 60,
          onChanged: (v) {
            notifier.updateSettings(
              settings.copyWith(sectionLabelFontSize: v.toDouble()),
            );
          },
        ),
      ],
    );
  }

  Widget layerSettings(
      ViewSettings settings, ModelViewerSettingsNotifier notifier) {
    return SettingsArea(
      label: "Layers",
      children: [
        SettingsSlider(
          label: "Label Font Size",
          value: () => settings.layerLabelFontSize,
          min: 6,
          max: 36,
          stops: 60,
          onChanged: (v) {
            notifier.updateSettings(
              settings.copyWith(layerLabelFontSize: v.toDouble()),
            );
          },
        ),
      ],
    );
  }
}

class SettingsArea extends ConsumerWidget {
  const SettingsArea({
    super.key,
    required this.label,
    required this.children,
  });

  final String label;
  final List<Widget> children;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Card(
        child: Column(
          children: [
            areaLabel(label),
            ...children,
          ],
        ),
      ),
    );
  }

  Padding areaLabel(String name) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20,
      ),
      child: Text(
        name,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ColorChanger extends StatelessWidget {
  const ColorChanger({
    Key? key,
    required this.label,
    required this.currentColor,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final Color currentColor;
  final Function(Color) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        right: 30,
      ),
      child: Row(
        children: [
          Expanded(
            child: SettingLabel(
              label: label,
            ),
          ),
          GestureDetector(
            onTap: () => colorDialog(
              context: context,
              color: currentColor,
              onChanged: (c) => onChanged.call(c),
            ),
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: currentColor,
                border: const Border(
                  top: BorderSide(),
                  bottom: BorderSide(),
                  left: BorderSide(),
                  right: BorderSide(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void colorDialog({
    required BuildContext context,
    required Color color,
    required Function(Color) onChanged,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: HueRingPicker(
            pickerColor: color,
            onColorChanged: onChanged,
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Got it'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
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
    required this.min,
    required this.max,
    this.stops = 0,
  }) : super(key: key);

  final String label;
  final num Function() value;
  final Function(num) onChanged;
  final double min;
  final double max;
  final int stops;

  @override
  Widget build(BuildContext context) {
    final v = value.call();
    return Stack(
      children: [
        SettingLabel(label: label),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              v.toString(),
              textAlign: TextAlign.center,
            ),
            stops > 0
                ? Slider(
                    value: v.toDouble(),
                    min: min,
                    max: max,
                    divisions: stops,
                    onChanged: (newV) => onChanged.call(newV),
                  )
                : Slider(
                    value: v.toDouble(),
                    min: min,
                    max: max,
                    onChanged: (newV) => onChanged.call(newV),
                  ),
          ],
        ),
      ],
    );
  }
}

class SettingLabel extends StatelessWidget {
  const SettingLabel({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Text(
        label,
      ),
    );
  }
}
