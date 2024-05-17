enum HTTPMethod {
  get(
    name: 'GET',
  ),
  post(
    name: 'POST',
  );

  final String name;

  const HTTPMethod({
    required this.name,
  });
}
