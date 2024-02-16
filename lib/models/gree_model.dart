class Gree {
  final int? id;
  final String? gree_name;
  final int? prompt_age;
  final String? prompt_jender;
  final String? prompt_mbti;
  final String raw_img;

  Gree({
    this.id,
    this.gree_name,
    this.prompt_age,
    this.prompt_jender,
    this.prompt_mbti,
    required this.raw_img,
  });

  factory Gree.fromJson(Map<String, dynamic> json) {
    return Gree(
      id: json['id'],
      gree_name: json['gree_name'],
      prompt_age: json['prompt_age'],
      prompt_jender: json['prompt_jender'],
      prompt_mbti: json['prompt_mbti'],
      raw_img: json['raw_img'],
    );
  }
}

class GreeUpdate {
  final String? gree_name;
  final int? prompt_age;
  final String? prompt_jender;
  final String? prompt_mbti;

  GreeUpdate({
    this.gree_name,
    this.prompt_age,
    this.prompt_jender,
    this.prompt_mbti,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (gree_name != null) {
      data['gree_name'] = gree_name;
    }
    if (prompt_age != null) {
      data['prompt_age'] = prompt_age;
    }
    if (prompt_jender != null) {
      data['prompt_jender'] = prompt_jender;
    }
    if (prompt_mbti != null) {
      data['prompt_mbti'] = prompt_mbti;
    }
    return data;
  }
}
