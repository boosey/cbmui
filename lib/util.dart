import 'package:flutter/material.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:http/http.dart' as http;
import 'models/component_business_model.dart';

const strategic = {
  "Strategic": 5,
  "Important": 4,
  "Tactical": 3,
  "Neutral": 2,
  "None": 1,
};

const relationship = {
  "Promoter": 5,
  "Trusted": 4,
  "Neutral": 3,
  "None": 2,
  "Negative": 1,
};

final createButtonStyle = ElevatedButton.styleFrom(
  fixedSize: const Size(30, 125),
  backgroundColor: Colors.white,
  foregroundColor: Colors.blue,
);

class ModelApi {
  static late Repository<Model> _repository;

  static setRepository(Repository<Model> repo) => _repository = repo;

  static Future<void> saveModel({required Model model}) async {
    await model.save();
    await _repository.findAll(syncLocal: true);
  }

  static Future<void> createLayer({required Model model}) async {
    await sendPost(url: 'http://localhost:8888/models/${model.id}/layers');

    await _repository.findAll(syncLocal: true);
  }

  static Future<void> createSection(
      {required Model model, required Layer layer}) async {
    await sendPost(
        url:
            'http://localhost:8888/models/${model.id}/layers/${layer.id}/sections');

    await _repository.findAll(syncLocal: true);
  }

  static Future<void> createComponent({
    required Model model,
    required Layer layer,
    required Section section,
  }) async {
    await sendPost(
        url:
            'http://localhost:8888/models/${model.mid}/layers/${layer.id}/sections/${section.id}/components');

    await _repository.findAll(syncLocal: true);
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
