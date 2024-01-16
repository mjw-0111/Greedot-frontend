import 'dart:ui';

class Node {
  Node(this.point, this.fromJoint, this.toJoint);
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
