enum ApiUrl {
  checkToken(
    path: 'user/check',
  ),
  photo(
    path: 'photo',
  ),
  signIn(
    path: 'user/sign_in',
  );

  final String path;

  const ApiUrl({
    required this.path,
  });
}
