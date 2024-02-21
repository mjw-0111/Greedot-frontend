import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../structure/structure.dart';
import '../../structure/structureInit.dart';
import '../../widget/design/basicButtons.dart';
import '../../provider/pageNavi.dart';
import '../../service/gree_service.dart';

class LoadingNotifier with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}

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
            height: elebutH,
            width: elebutW,
            additionalFunc: ()  async {
              if (greeid == null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('gree_id가 없습니다.')));
                return;
              }
              showLoadingDialog(context); // 로딩 대화 상자 표시
              try {
                await writeNodesToYaml(skeletonInfo, imageWidth, imageHeight, greeid);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('YAML 파일이 서버에 저장됨')));
              } finally {
                closeLoadingDialog(context);// 로딩 종료
                pageNavi.changePage('ChatPage',  data: PageData(greeId: greeid));
              }
            },
            buttonText: '그리 생성하기',
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

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // 사용자가 대화 상자 외부를 탭해도 닫히지 않도록 설정
    builder: (BuildContext context) {
      return AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20), // 스피너와 텍스트 사이의 간격
            Text("생성 중입니다..."),
          ],
        ),
      );
    },
  );
}

void closeLoadingDialog(BuildContext context) {
  Navigator.of(context).pop(); // 대화 상자 닫기
}