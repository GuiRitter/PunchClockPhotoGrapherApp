import 'package:flutter/material.dart' show IntrinsicColumnWidth;

buildIntrinsicColumnWidthMap({
  required int count,
}) =>
    {
      for (final index in Iterable<int>.generate(
        count,
      ))
        index: const IntrinsicColumnWidth(),
    };
