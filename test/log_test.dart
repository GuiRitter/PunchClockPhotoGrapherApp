import 'package:flutter_guiritter/util/_import.dart' show logger;
import 'package:flutter_test/flutter_test.dart' show test;

void main() {
  test('log of map', () async {
    final map = {
      'a': 1,
      'b': 2,
    };

    _log('test').raw('map', map).print();
  });
}

final _log = logger('test');
