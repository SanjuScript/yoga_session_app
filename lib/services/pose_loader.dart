import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/pose_model.dart';

class PoseLoader {
  static Future<YogaSession> loadSession(String path) async {
    final jsonStr = await rootBundle.loadString(path);
    final data = json.decode(jsonStr);
    return YogaSession.fromJson(data);
  }
}
