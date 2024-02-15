import 'package:flutter/material.dart';
import '../../widget/design/settingColor.dart';
import 'package:projectfront/widget/design/basicButtons.dart';
import '../rigging/getImage.dart'; // 버튼 사용을 위해 넣음

class FavoriteItemCard extends StatefulWidget {
  final String image;
  final String name;
  final String mbti;
  final String description;

  FavoriteItemCard({
    Key? key,
    required this.image,
    required this.name,
    required this.mbti,
    required this.description,
  }) : super(key: key);


  @override
  _FavoriteItemCardState createState() => _FavoriteItemCardState();
}

class _FavoriteItemCardState extends State<FavoriteItemCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: colorFilling_greedot,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Image.asset(
                widget.image,
                fit: BoxFit.cover,
                width: 120, height: 120,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(bottom: 70),
              child: EleButton_greedot(
                isSmall: true,
                gotoScene: () => GetImage_greedot(),
                buttonText: "대화 시작",
              ),
            ),
          ),
          Positioned(
            top: 140,
            left: 8,
            right: 8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(widget.mbti),
                Text(widget.description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
