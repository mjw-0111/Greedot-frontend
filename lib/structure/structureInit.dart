import 'dart:ui';

import '../structure/structure.dart';

import 'package:image_picker/image_picker.dart';

//로그인 여부 확인 향후 backend로 빼야할수도 있음
bool? isLogIn;

//임시 선언 위치
XFile? importedImage;

List<Joint> skeletonInfo = [
  Joint(const Offset(166, 248), "root", null),
  Joint(const Offset(166, 248), "hip", "root"),
  Joint(const Offset(166, 133), "torso", "hip"),
  Joint(const Offset(169, 51), "neck", "torso"),
  Joint(const Offset(134, 133), "right_shoulder", "torso"),
  Joint(const Offset(82, 142), "right_elbow", "right_shoulder"),
  Joint(const Offset(21, 150), "right_hand", "right_elbow"),
  Joint(const Offset(199, 133), "left_shoulder", "torso"),
  Joint(const Offset(255, 137), "left_elbow", "left_shoulder"),
  Joint(const Offset(316, 146), "left_hand", "left_elbow"),
  Joint(const Offset(143, 250), "right_hip", "root"),
  Joint(const Offset(147, 320), "right_knee", "right_hip"),
  Joint(const Offset(147, 380), "right_foot", "right_knee"),
  Joint(const Offset(190, 246), "left_hip", "root"),
  Joint(const Offset(195, 320), "left_knee", "left_hip"),
  Joint(const Offset(199, 380), "left_foot", "left_knee"),
];
