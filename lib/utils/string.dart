extension StringExtension on String? {
  String? get nullIfEmpty => (this == "") ? null : this;
}