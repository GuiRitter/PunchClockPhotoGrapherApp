enum ApiUrl {
  signIn(
    path: "user/sign_in",
  ),
  photo(
    path: "photo",
  );

  final String path;

  const ApiUrl({
    required this.path,
  });
}
