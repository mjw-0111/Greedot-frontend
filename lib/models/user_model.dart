//로그인 모델 구조
class LoginModel {
  final String username;
  final String password;

  LoginModel({required this.username, required this.password});
}

//회원가입 모델 구조
class RegisterModel {
  final String username;
  final String nickname;
  final String password;

  RegisterModel({
    required this.username,
    required this.nickname,
    required this.password,
  });
}

// 유저 정보 수정 모델 구조
class UserUpdateModel {
  final int id;
  final String? username;
  final String? nickname;
  final String? password;

  UserUpdateModel({required this.id, this.username, this.nickname, this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (username != null) {
      data['username'] = username;
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

enum RoleEnum { ADMIN, MANAGER, MEMBER}
enum GradeEnum { FREE, BASIC, PREMIUM}

// UserModel 정의
class UserModel {
  final int id;
  final String username;
  final String nickname;
  final RoleEnum role;
  final GradeEnum grade;

  UserModel({required this.id, required this.username, required this.nickname, required this.role, required this.grade});

// UserModel 클래스 내에서 열거형 처리
  factory UserModel.fromJson(Map<String, dynamic> json) {
  return UserModel(
  id: json['id'],
  username: json['username'],
  nickname: json['nickname'],
  role: RoleEnum.values.firstWhere((e) => e.toString().split('.').last.toUpperCase() == json['role']),
  grade: GradeEnum.values.firstWhere((e) => e.toString().split('.').last.toUpperCase() == json['grade']),
  );
  }
  String get gradeString => grade.toString().split('.').last;
}

class UserProfileUpdateModel {
  final String? nickname;

  UserProfileUpdateModel({this.nickname});

  Map<String, dynamic> toJson() {
    return {
      if (nickname != null) 'nickname': nickname,
    };
  }
}