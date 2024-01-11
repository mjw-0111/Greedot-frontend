import 'dart:ui';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../structure/structureInit.dart';

import 'package:path_provider/path_provider.dart';

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

Future<File> writeNodesToYaml(
    List<Node> nodes, double width, double height) async {
  final directory = await getApplicationDocumentsDirectory();
  final dir = Directory(directory.path);
  if (!await dir.exists()) {
    await dir.create(recursive: true);
  }
  final file = File('${dir.path}/skeleton.yaml');

  // YAML 형식 문자열 생성
  String yaml = 'height: ${height.toInt()}\nskeleton:\n';
  for (var node in nodes) {
    yaml +=
        '- loc:\n  - ${node.point.dx.toInt()}\n  - ${node.point.dy.toInt()}\n';
    yaml += '  name: ${node.fromJoint}\n';
    yaml += '  parent: ${node.toJoint ?? 'null'}\n';
  }
  yaml += 'width: ${width.toInt()}';

  print(directory);
  return file.writeAsString(yaml);
}

// YAML 저장 버튼의 onPressed 콜백
void onSaveYamlPressed() async {
  try {
    await writeNodesToYaml(skeletonInfo, 333, 392); // 이미지의 너비와 높이를 인자로 전달
    print('YAML 저장 완료');
  } catch (e) {
    print('YAML 저장 실패: $e');
  }
}
