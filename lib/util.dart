import 'package:flutter/material.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:http/http.dart' as http;
import 'models/component_business_model.dart';

final createButtonStyle = ElevatedButton.styleFrom(
  fixedSize: const Size(30, 125),
  backgroundColor: Colors.white,
  foregroundColor: Colors.blue,
// side: const BorderSide(width: 1, color: Colors.black),
);

class ModelApi {
  static Future<void> saveModel(
      {required Repository<Model> repository, required Model model}) async {
    // await sendPut(
    //   url: 'http://localhost:8888/models/${model.mid}/layers',
    //   model: model.save(),
    // );
    await model.save();
    await repository.findAll(syncLocal: true);
  }

  static Future<void> createLayer(
      {required Repository<Model> repository, required Model model}) async {
    await sendPost(url: 'http://localhost:8888/models/${model.id}/layers');

    await repository.findAll(syncLocal: true);
  }

  static Future<void> createSection(
      {required Repository<Model> repository,
      required Model model,
      required Layer layer}) async {
    await sendPost(
        url:
            'http://localhost:8888/models/${model.id}/layers/${layer.id}/sections');

    await repository.findAll(syncLocal: true);
  }

  static Future<void> createComponent({
    required Repository<Model> repository,
    required Model model,
    required Layer layer,
    required Section section,
  }) async {
    await sendPost(
        url:
            'http://localhost:8888/models/${model.mid}/layers/${layer.id}/sections/${section.id}/components');

    await repository.findAll(syncLocal: true);
  }

  static Future<void> sendPost({required String url}) async {
    await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: "{}",
    );
    return;
  }

  static Future<void> sendPut(
      {required String url, required Model model}) async {
    await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: Model,
    );
    return;
  }
}
