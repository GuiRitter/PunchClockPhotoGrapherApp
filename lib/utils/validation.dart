String? getRequiredStringError({
  required String? value,
  required String errorMessage,
}) =>
    (value?.isEmpty ?? true) ? errorMessage : null;
