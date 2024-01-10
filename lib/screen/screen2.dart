import 'package:flutter/material.dart';
import 'structure.dart';
import 'screen.dart';

List<Node2> buttonDescriptions = [
  Node2(const Offset(166, 248), "root"),
  Node2(const Offset(166, 248), "hip"),
  Node2(const Offset(166, 133), "torso"),
  Node2(const Offset(169, 51), "neck"),
  Node2(const Offset(134, 133), "right_shoulder"),
  Node2(const Offset(82, 142), "right_elbow"),
  Node2(const Offset(21, 150), "right_hand"),
  Node2(const Offset(199, 133), "left_shoulder"),
  Node2(const Offset(255, 137), "left_elbow"),
  Node2(const Offset(316, 146), "left_hand"),
  Node2(const Offset(143, 250), "right_hip"),
  Node2(const Offset(147, 320), "right_knee"),
  Node2(const Offset(147, 380), "right_foot"),
  Node2(const Offset(190, 246), "left_hip"),
  Node2(const Offset(195, 320), "left_knee"),
  Node2(const Offset(199, 380), "left_foot"),
];

//global var
double radiusDragBut = 15.0;

class Screen2 extends StatefulWidget {
  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  List<Offset> positions = List.generate(buttonDescriptions.length,
          (index) => Offset(100.0 * (index + 1), 100.0));
  var offsetX = 0.0;
  var offsetY = 0.0;
  var preX = 0.0;
  var preY = 0.0;
  var trigger = false;

  //음 여기 선언하는게 맞나?
  bool _initState = true;
  var moveX, moveY, newPosX, newPosY;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: LinePainter(positions),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TestScreen()),
                      );
                    },
               child: const Text('홈으로 가기')
            ),
          ),
        ),

          // Draggable buttons
          ...List.generate(buttonDescriptions.length, (index) {
            return Positioned(
              left: buttonDescriptions[index].point.dx,
              top: buttonDescriptions[index].point.dy,
              child: Draggable(
                feedback: _buildDraggableCircle(index),
                onDragStarted: () {},
                onDragUpdate: (updateDragDetails) {
                  if (_initState) {
                    moveX = updateDragDetails.localPosition.dx -
                        buttonDescriptions[index].point.dx;
                    moveY = updateDragDetails.localPosition.dy -
                        buttonDescriptions[index].point.dy;
                    _initState = false;
                  }
                  newPosX = updateDragDetails.localPosition.dx - moveX;
                  newPosY = updateDragDetails.localPosition.dy - moveY;
                  // positions[index] = Offset(newPosX, newPosY);
                  print(newPosX);
                  _onDrag(index, Offset(newPosX, newPosY));
                },
                onDragEnd: (endDragDetails) {
                  _initState = true;
                },
                child: _buildDraggableCircle(index),
              ),
            );
          }),
          // Display position information
          Positioned(
            left: 10.0,
            bottom: 10.0,
            child: _buildPositionInfo(),
          ),
        ],
      ),
    );
  }

  Widget _buildDraggableCircle(int index) {
    return Tooltip(
      message: buttonDescriptions[index].name, // 여기서 한글 설명을 사용합니다.
      child: CircleAvatar(radius: radiusDragBut, child: Text('${index + 1}')),
    );

    return CircleAvatar(radius: radiusDragBut, child: Text('${index + 1}'));

  }

  Widget _buildPositionInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: buttonDescriptions
          .asMap()
          .entries
      // .where((entry) =>
      //     entry.key != 2) // Do not display information for the 3rd button
          .map((entry) => Text(
          'Button ${entry.key + 1}: (${entry.value.point.dx.toStringAsFixed(2)}, ${entry.value.point.dy.toStringAsFixed(2)})'))
          .toList(),
    );
  }

  void _onDrag(int index, Offset offset) {
    setState(() {
      buttonDescriptions[index].point = offset;
    });
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

    for (int i = 0; i < buttonDescriptions.length - 1; i++) {
      Offset coord1 = Offset(
          buttonDescriptions[i].point.dx + radiusDragBut, buttonDescriptions[i].point.dy + radiusDragBut);
      Offset coord2 = Offset(buttonDescriptions[i + 1].point.dx + radiusDragBut,
          buttonDescriptions[i + 1].point.dy + radiusDragBut);
      canvas.drawLine(coord1, coord2, paint);

    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}