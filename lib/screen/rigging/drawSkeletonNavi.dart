import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../structure/structure.dart';
import '../../structure/structureInit.dart';
import '../../widget/design/basicButtons.dart';
import '../../provider/pageNavi.dart';
import '../../service/gree_service.dart';

Align drawSkeletonNavi(BuildContext context, double imageWidth, double imageHeight, int? greeid) {
  double elebutW= 120;
  double elebutH= 40;
  double paddingBWbut = 10;
  final pageNavi = Provider.of<PageNavi>(context, listen: false);
  return Align(
         alignment: Alignment.bottomCenter,
         child: Padding(
           padding: EdgeInsets.all(paddingBWbut),
           child: Row(
             mainAxisSize: MainAxisSize.min,
             crossAxisAlignment: CrossAxisAlignment.end,
             children: <Widget>[
               EleButton_greedot(
                 height: elebutH, // 높이 설정
                 width: elebutW, // 너비 설정
                 additionalFunc: () {
                   for (var node in skeletonInfo) {
                     print(
                         '${node.fromJoint} = (${node.point.dx}, ${node.point.dy})');
                   }
                 },
                 buttonText: '좌표 출력',
               ),
               SizedBox(width: paddingBWbut),
               EleButton_greedot(
                 height: elebutH,
                 width: elebutW,
                 additionalFunc: () async {
                   if (greeid != null) {
                     await writeNodesToYaml(
                         skeletonInfo, imageWidth, imageHeight, greeid);
                     ScaffoldMessenger.of(context)
                         .showSnackBar(SnackBar(content: Text('YAML 파일이 서버에 저장됨')));
                   } else {
                     ScaffoldMessenger.of(context)
                         .showSnackBar(SnackBar(content: Text('gree_id가 없습니다.')));
                   }
                 },
                 buttonText: 'Yaml 저장',
               ),
             ],
           ),
         ),
       );
 }
Future<void> writeNodesToYaml(
    List<Joint> nodes, double width, double height, int? greeId) async {
  if (greeId == null) {
    print('greeId is null');
    return;
  }
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

  await file.writeAsString(yaml);

  await ApiServiceGree.uploadYamlFileToServer(file.path, greeId);

  await ApiServiceGree.uploadFilesToBackend(greeId);
}

