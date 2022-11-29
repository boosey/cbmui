import 'package:cbmui/api/model_api.dart';
import 'package:flutter/material.dart';

import '../models/component_business_model.dart';
import 'model_viewer.dart';

enum _TMItem {
  open,
  copy,
  delete,
}

class ThumbnailMenu extends StatelessWidget {
  const ThumbnailMenu({
    super.key,
    required this.model,
  });

  final Model model;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_TMItem>(
      onSelected: (value) {
        switch (value) {
          case _TMItem.open:
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ModelViewer(mid: model.mid)),
            );
            break;
          case _TMItem.copy:
            break;
          case _TMItem.delete:
            () async {
              await ModelApi.deleteModel(id: model.mid);
            }.call();
            break;
          default:
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem<_TMItem>(
          value: _TMItem.open,
          child: Text("Open"),
        ),
        const PopupMenuItem<_TMItem>(
          value: _TMItem.copy,
          child: Text("Copy"),
        ),
        const PopupMenuItem<_TMItem>(
          value: _TMItem.delete,
          child: Text("Delete"),
        ),
      ],
    );
  }
}
