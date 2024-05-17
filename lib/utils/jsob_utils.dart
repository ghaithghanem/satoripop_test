import 'package:flutter/foundation.dart';

class JsonUtils<T> {
  static DateTime? date(dynamic dateString) {
    if (dateString != null) {
      try {
        return DateTime.parse(dateString);
      } catch (e) {
        if (kDebugMode) print(e);
        return null;
      }
    }
    return null;
  }
}
