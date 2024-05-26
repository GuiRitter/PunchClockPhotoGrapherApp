extension MapExtension<K, V> on Map<K, V> {
  V? getValueOrNew({
    required K key,
    required V Function() generator,
  }) =>
      containsKey(
        key,
      )
          ? this[key]
          : generator();
}
