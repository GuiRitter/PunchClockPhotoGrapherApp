enum ApiUrl {
  photo(
    path: 'photo',
  );

  final String path;

  const ApiUrl({
    required this.path,
  });
}
