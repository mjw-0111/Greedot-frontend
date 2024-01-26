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