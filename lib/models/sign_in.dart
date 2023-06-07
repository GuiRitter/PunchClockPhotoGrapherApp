class SignIn {
  late String userId;
  late String password;

  SignIn({required this.userId, required this.password});

  SignIn.fromJson(Map<String, dynamic> json) {
    userId = json['login'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['login'] = userId;
    data['password'] = password;
    return data;
  }
}
