//로그인 모델 구조
class LoginModel {
  final String username;
  final String password;

  LoginModel({required this.username, required this.password});
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

// 유저 정보 수정 모델 구조
class UserUpdateModel {
  final int id;
  final String? email;
  final String? nickname;
  final String? password;

  UserUpdateModel({required this.id, this.email, this.nickname, this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (email != null) {
      data['email'] = email;
    }
    if (nickname != null) {
      data['nickname'] = nickname;
    }
    if (password != null) {
      data['password'] = password;
    }
    return data;
  }
}