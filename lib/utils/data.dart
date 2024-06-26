extension MapExtension<K, V> on Map<K, V> {
  V? getValueOrNew({
    required K key,
    required V Function() generator,
  }) {
    if (containsKey(
      key,
    )) {
      return this[key];
    } else {
      final value = generator();
      this[key] = value;
      return value;
    }
  }
}
