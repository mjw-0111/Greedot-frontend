import 'dart:ui';

import '../structure/structure.dart';

import 'package:image_picker/image_picker.dart';

//임시 선언 위치
XFile? importedImage;

List<Node> skeletonInfo = [
  Node(const Offset(166, 248), "root", null),
  Node(const Offset(166, 248), "hip", "root"),
  Node(const Offset(166, 133), "torso", "hip"),
  Node(const Offset(169, 51), "neck", "torso"),
  Node(const Offset(134, 133), "right_shoulder", "torso"),
  Node(const Offset(82, 142), "right_elbow", "right_shoulder"),
  Node(const Offset(21, 150), "right_hand", "right_elbow"),
  Node(const Offset(199, 133), "left_shoulder", "torso"),
  Node(const Offset(255, 137), "left_elbow", "left_shoulder"),
  Node(const Offset(316, 146), "left_hand", "left_elbow"),
  Node(const Offset(143, 250), "right_hip", "root"),
  Node(const Offset(147, 320), "right_knee", "right_hip"),
  Node(const Offset(147, 380), "right_foot", "right_knee"),
  Node(const Offset(190, 246), "left_hip", "root"),
  Node(const Offset(195, 320), "left_knee", "left_hip"),
  Node(const Offset(199, 380), "left_foot", "left_knee"),
];
