import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../structure/structure.dart';
import '../../structure/structureInit.dart';
import '../../widget/design/basicButtons.dart';
import '../../provider/pageNavi.dart';

Align drawSkeletonNavi(BuildContext context, double imageWidth, double imageHeight) {
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
                   await writeNodesToYaml(
                       skeletonInfo, imageWidth, imageHeight);
                   ScaffoldMessenger.of(context)
                       .showSnackBar(SnackBar(content: Text('Yaml 파일 저장됨')));
                 },
                 buttonText: 'Yaml 저장',
               ),
              SizedBox(width: paddingBWbut),
               EleButton_greedot(
                 height: elebutH,
                 width: elebutW,
                    additionalFunc: () => pageNavi.changePage('SettingPersonality'),
                 buttonText: '인성 정하기',
               ),
             ],
           ),
         ),
       );
 }
 Future<File> writeNodesToYaml(
     List<Joint> nodes, double width, double height) async {
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
   return file.writeAsString(yaml);
 }
