// import 'package:cbmui/providers/zoom_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Zoom extends ConsumerWidget {
  const Zoom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();

    //   ToggleButtons(
    //     onPressed: (index) {
    //       switch (index) {
    //         case 0:
    //           ref.read(zoomFactorProvider.notifier).zoomOut();
    //           break;
    //         case 1:
    //           ref.read(zoomFactorProvider.notifier).zoomIn();
    //           break;
    //         default:
    //       }
    //     },
    //     isSelected: const [
    //       false,
    //       false,
    //     ],
    //     children: const [
    //       Icon(Icons.zoom_out_map_outlined),
    //       Icon(Icons.zoom_in_map_outlined),
    //     ],
    //   );
  }
}
