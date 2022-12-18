import 'dart:convert';

import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../models/component_business_model.dart';

class ModelApi {
  static late Repository<Model> _repository;

  static setRepository(Repository<Model> repo) => _repository = repo;

  static String get baseURL =>
      dotenv.get('BASE_URL', fallback: 'BASE URL not found');

  static Future<void> createModel() async {
    await sendPost(url: '$baseURL/models');
    await _repository.findAll(syncLocal: true);
  }

  static Future<void> copyModel({required String mid}) async {
    await sendGet(url: '$baseURL/models/$mid?copy');
    await _repository.findAll(syncLocal: true);
  }

  static Future<void> deleteModel({required String mid}) async {
    await sendDelete(url: '$baseURL/models/$mid');
    await _repository.findAll(syncLocal: true);
  }

  static Future<void> saveModel({required Model model}) async {
    await model.save();
    await _repository.findAll(syncLocal: true);
  }

  static Future<void> createLayer({required Model model}) async {
    await sendPost(url: '$baseURL/models/${model.id}/layers');
    await _repository.findAll(syncLocal: true);
  }

  static Future<void> createSection(
      {required Model model, required Layer layer}) async {
    await sendPost(
        url: '$baseURL/models/${model.id}/layers/${layer.id}/sections');

    await _repository.findAll(syncLocal: true);
  }

  static Future<void> createComponent({
    required Model model,
    required Layer layer,
    required Section section,
  }) async {
    await sendPost(
        url:
            '$baseURL/models/${model.id}/layers/${layer.id}/sections/${section.id}/components');

    await _repository.findAll(syncLocal: true);
  }

  static Future<List<String>> getTags() async {
    var r = await sendGet(url: '$baseURL/models/tags');
    List<dynamic> tags = jsonDecode(r.body);
    var tags2 = <String>[];
    for (var t in tags) {
      tags2.add(t.toString());
    }
    return Future.value(tags2);
  }

  static Future<void> addTag(String newOption) async {
    await sendPost(
        url: '$baseURL/models/tags', body: newOption, isPlainText: true);
    return;
  }

  static Future<void> deleteTag(String oldOption) async {
    await sendDelete(url: '$baseURL/models/tags/$oldOption');
    return;
  }

  static Future<void> sendPost(
      {required String url, String body = "", bool isPlainText = false}) async {
    await http.post(
      Uri.parse(url),
      headers: isPlainText
          ? <String, String>{
              'Content-Type': 'text/plain',
            }
          : <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
      body: body,
    );
    return;
  }

  static Future<Response> sendGet({required String url}) async {
    return await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }

  static Future<void> sendDelete({required String url}) async {
    await http.delete(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
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
