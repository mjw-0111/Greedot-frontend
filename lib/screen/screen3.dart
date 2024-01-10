import 'package:flutter/material.dart';
import 'structure.dart';
import 'screen.dart';

//global var
double radiusDragBut = 15.0;

class Screen3 extends StatefulWidget {
  @override
  _Screen3State createState() => _Screen3State();
}


List<Node> buttonDescriptions_ = [
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

class _Screen3State extends State<Screen3> {

  List<Offset> positions = List.generate(buttonDescriptions_.length,
          (index) => Offset(100.0 * (index + 1), 100.0));


  var offsetX = 0.0;
  var offsetY = 0.0;
  var preX = 0.0;
  var preY = 0.0;
  var trigger = false;

  //음 여기 선언하는게 맞나?
  bool _initState = true;
  var moveX, moveY, newPosX, newPosY;

  double get imageWidth => 450;
  double get imageHeight => 600;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: imageWidth,
            height: imageHeight,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red), // 테두리 추가
              color: Colors.blue.shade100, // 배경 색상 추가
            ),
            child: Image.asset(
              'assets/images/test.png',
              fit: BoxFit.contain, // BoxFit 조정
            ),
          ),
          Positioned.fill(
            child: CustomPaint(
              painter: LinePainter(positions),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      // 버튼들의 현재 좌표값을 출력
                      for (var node in buttonDescriptions_) {
                        print('${node.fromJoint} = (${node.point.dx}, ${node.point.dy})');
                      }
                    },
                    child: const Text('좌표 출력'),
                  ),
                  SizedBox(height: 10),
                  // JSON 저장 버튼
                  ElevatedButton(
                    onPressed: () async {
                      await writeNodesToYaml(buttonDescriptions_, imageWidth, imageHeight);
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Yaml 파일 저장됨'))
                      );
                    },
                    child: const Text('Yaml 저장'),
                  ),
                  SizedBox(height: 10), // 버튼 사이의 간격
                  // 홈으로 가기 버튼
                  ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const TestScreen()),
                      );
                    },
                    child: const Text('홈으로 가기'),
                  ),
                ],
              ),
            ),
          ),


          // Draggable buttons
          ...List.generate(buttonDescriptions_.length, (index) {
            return Positioned(
              left: buttonDescriptions_[index].point.dx,
              top: buttonDescriptions_[index].point.dy,
              child: Draggable(
                feedback: _buildDraggableCircle(index),
                onDragStarted: () {},
                onDragUpdate: (updateDragDetails) {
                  if (_initState) {
                    moveX = updateDragDetails.localPosition.dx -
                        buttonDescriptions_[index].point.dx;
                    moveY = updateDragDetails.localPosition.dy -
                        buttonDescriptions_[index].point.dy;
                    _initState = false;
                  }
                  newPosX = updateDragDetails.localPosition.dx - moveX;
                  newPosY = updateDragDetails.localPosition.dy - moveY;
                  // positions[index] = Offset(newPosX, newPosY);
                  if (newPosX >= 0 && newPosX <= imageWidth && newPosY >= 0 && newPosY <= imageHeight)
                    _onDrag(index, Offset(newPosX, newPosY));
                },
                onDragEnd: (endDragDetails) {
                  _initState = true;
                },
                child: _buildDraggableCircle(index),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDraggableCircle(int index) {
    return Tooltip(
      message: buttonDescriptions_[index].fromJoint, // 여기서 한글 설명을 사용합니다.
      child: CircleAvatar(radius: radiusDragBut, child: Text('${index + 1}')),
    );
  }


  void _onDrag(int index, Offset offset) {
    // 드래그 위치가 이미지 영역 내에 있는지 확인
    bool withinWidthBounds = offset.dx >= 0 && offset.dx <= imageWidth;
    bool withinHeightBounds = offset.dy >= 0 && offset.dy <= imageHeight;

    // 조건을 만족하면 상태 업데이트
    if (withinWidthBounds && withinHeightBounds) {
      setState(() {
        buttonDescriptions_[index].point = offset;
      });
    }
  }


}

class LinePainter extends CustomPainter {
  final List<Offset> positions;

  LinePainter(this.positions);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    for (Node fromJ in buttonDescriptions_) {
      String currentJoint = fromJ.fromJoint;
      for (Node toJ in buttonDescriptions_){
        String? connectedJoint = toJ.toJoint;
        if (currentJoint == connectedJoint){
          Offset coord1 = Offset(
              fromJ.point.dx + radiusDragBut, fromJ.point.dy + radiusDragBut);
          Offset coord2 = Offset(toJ.point.dx + radiusDragBut,
              toJ.point.dy + radiusDragBut);
          canvas.drawLine(coord1, coord2, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}