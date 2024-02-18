import 'package:flutter/material.dart';
import '../../widget/design/settingColor.dart';
import '../../models/gree_model.dart';
import 'package:projectfront/widget/design/basicButtons.dart';
import '../rigging/getImage.dart'; // 버튼 사용을 위해 넣음

class FavoriteItemCard extends StatefulWidget {
  final Gree gree;

  FavoriteItemCard({
    Key? key,
    required this.gree,
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
              // Image.network 사용, DB에서 불러온 이미지 주소를 사용
              child: Image.network(
                widget.gree.raw_img,
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
                  widget.gree.gree_name ?? 'Unknown', // null 처리
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(widget.gree.prompt_mbti ?? 'Unknown'), // null 처리
              ],
            ),
          ),
        ],
      ),
    );
  }
}
