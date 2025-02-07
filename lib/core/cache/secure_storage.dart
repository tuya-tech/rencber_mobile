import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rencber_mobile/product/models/field/field_response.dart';

class SecureStorage {
  SecureStorage._();
  static final instance = SecureStorage._();
  final storage = const FlutterSecureStorage();

  Future<void> writeSecureData(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<String?> readSecureData(String key) async {
    try {
      final readData = await storage.read(key: key);
      return readData;
    } on PlatformException {
      await storage.deleteAll();
    }
    return null;
  }

  Future<void> deleteSecureData() async {
    await storage.delete(key: 'phone');
    await storage.delete(key: 'accessToken');
    await storage.delete(key: 'refreshToken');
  }

  Future<void> deleteSecureDataSpec(String key) async {
    await storage.delete(key: key);
  }

  Future<void> allDeleteSecureData() async {
    await storage.deleteAll();
  }

  Future<void> deleteAllSearchQueries() async {
    await storage.delete(key: 'key');
  }

  Future<List<dynamic>> readListSecureData(String key) async {
    final listEncoded = await storage.read(key: key);
    if (listEncoded != null) {
      return jsonDecode(listEncoded) as List;
    }
    return [];
  }

  Future<void> writeListSecureData(String key, List value) async {
    final listEncoded = jsonEncode(value);
    await storage.write(key: key, value: listEncoded);
  }

  Future<void> writeFieldModel(String key, FieldResponseModel model) {
    final modelEncoded = jsonEncode(model);
    return storage.write(key: key, value: modelEncoded);
  }

  Future<FieldResponseModel?> readFieldModel(String key) async {
    final modelEncoded = await storage.read(key: key);
    if (modelEncoded != null) {
      return FieldResponseModel.fromJson(jsonDecode(modelEncoded));
    }
    return null;
  }
}
