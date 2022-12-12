import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
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

  static Future<void> sendGet({required String url}) async {
    await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return;
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
