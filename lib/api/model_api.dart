import 'dart:convert';

import 'package:cbmui/providers/model_list_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../models/cbmodel.dart';
import '../models/layer.dart';
import '../models/section.dart';

class ModelApi {
  static Ref? ref;
  static String get baseURL => dotenv.get('BASE_URL');

  static Future<void> refreshModels() async {
    return ref!.read(modelListProvider.notifier).refresh();
  }

  static Future<void> createModel() async {
    await sendPost(url: '$baseURL/models');
    await ModelApi.refreshModels();
  }

  static Future<void> copyModel({required String mid}) async {
    await sendGet(url: '$baseURL/models/$mid?copy');
    await ModelApi.refreshModels();
  }

  static Future<void> deleteModel({
    required String mid,
  }) async {
    await sendDelete(url: '$baseURL/models/$mid');
    await ModelApi.refreshModels();
  }

  static Future<void> deleteLayer({
    required String mid,
    required String lid,
  }) async {
    await sendDelete(url: '$baseURL/models/$mid/layers/$lid');
    await ModelApi.refreshModels();
  }

  static Future<void> deleteSection({
    required String mid,
    required String lid,
    required String sid,
  }) async {
    await sendDelete(url: '$baseURL/models/$mid/layers/$lid/sections/$sid');
    await ModelApi.refreshModels();
  }

  static Future<void> deleteComponent({
    required String mid,
    required String lid,
    required String sid,
    required String cid,
  }) async {
    await sendDelete(
        url: '$baseURL/models/$mid/layers/$lid/sections/$sid/components/$cid');
    await ModelApi.refreshModels();
  }

  static Future<void> saveCBModel({required CBModel model}) async {
    await sendPut(
      url: '$baseURL/models/${model.id}',
      model: model,
    );
    await ModelApi.refreshModels();
  }

  static Future<void> createLayer({required CBModel model}) async {
    await sendPost(url: '$baseURL/models/${model.id}/layers');
    await ModelApi.refreshModels();
  }

  static Future<void> createSection(
      {required CBModel model, required Layer layer}) async {
    await sendPost(
        url: '$baseURL/models/${model.id}/layers/${layer.id}/sections');

    await ModelApi.refreshModels();
  }

  static Future<void> createComponent({
    required CBModel model,
    required Layer layer,
    required Section section,
  }) async {
    await sendPost(
        url:
            '$baseURL/models/${model.id}/layers/${layer.id}/sections/${section.id}/components');

    await ModelApi.refreshModels();
  }

  static Future<List<CBModel>> getModels() async {
    var r = await sendGet(url: '$baseURL/models');
    List<dynamic> models = jsonDecode(r.body);
    var models2 = <CBModel>[];
    for (var m in models) {
      models2.add(CBModel.fromJson(m));
    }
    return Future.value(models2);
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

  static Future<int> sendDelete({required String url}) async {
    await http.delete(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    return Future.value(1);
  }

  static Future<void> sendPut(
      {required String url, required CBModel model}) async {
    await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(model.toJson()),
    );
    return;
  }
}
