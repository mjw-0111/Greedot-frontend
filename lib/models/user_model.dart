//로그인 모델 구조
class LoginModel {
  final String email;
  final String password;

  LoginModel({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

//회원가입 모델 구조
class RegisterModel {
  final String email;
  final String nickname;
  final String password;

  RegisterModel({
    required this.email,
    required this.nickname,
    required this.password,
  });
}