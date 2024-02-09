import 'dart:ui';

class Joint {
  Joint(this.point, this.fromJoint, this.toJoint);
  Offset point;
  String fromJoint;
  String? toJoint;

  Map<String, dynamic> toJson() {
    return {
      'loc': [point.dx.toInt(), point.dy.toInt()],
      'name': fromJoint,
      'parent': toJoint,
    };
  }
}

class User {
  User(this.email, this.nickname, this.password, this.role, this.status,
      this.grade, this.register_at);
  String email;
  String nickname;
  String password;
  List<Enum>? role;
  Enum status;
  Enum grade;
  Date register_at;
}

class Date {}

class Gree {
  Gree({
    required this.name,
    required this.age,
    required this.sex,
    required this.MBTI,
  });

  String name;
  String age;
  String sex;
  String MBTI;
}

