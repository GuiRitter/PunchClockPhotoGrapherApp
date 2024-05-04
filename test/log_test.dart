import 'package:flutter_test/flutter_test.dart';
import 'package:punch_clock_photo_grapher_app/utils/logger.dart';

void main() {
  test("log of map", () async {
    final map = {
      "a": 1,
      "b": 2,
    };

    _log("test").raw("map", map).print();
  });
}

final _log = logger("test");