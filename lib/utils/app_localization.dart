import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:get/get.dart';

class AppLocalization extends Translations {
  static Map<String, Map<String, String>> translations = {};

  static Future<void> init() async {
    translations['en_US'] =
    Map<String, String>.from(await _loadJson('localization/en_US.json'));
    translations['bn_BD'] =
    Map<String, String>.from(await _loadJson('localization/bn_BD.json'));
  }

  static Future<Map<String, dynamic>> _loadJson(String path) async {
    String data = await rootBundle.loadString('lib/$path');
    return json.decode(data);
  }

  @override
  Map<String, Map<String, String>> get keys => translations;
}
