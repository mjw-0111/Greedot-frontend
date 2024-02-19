import 'package:flutter/material.dart';
import '../../service/gree_service.dart';
import '../../widget/design/settingColor.dart';
import '../../models/gree_model.dart';
import 'package:projectfront/widget/design/basicButtons.dart';
import '../rigging/getImage.dart';
import '../../screen/root.dart';
import '../../provider/pageNavi.dart';
import 'package:provider/provider.dart';

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
    final pageNavi = Provider.of<PageNavi>(context, listen: false);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: colorFilling_greedot,
      child: Stack(
        children: [
          FutureBuilder<String?>(
            future: ApiServiceGree.fetchSpecificGreeGif(widget.gree.id ?? 0),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError || !snapshot.hasData) {
                String errorMessage = "Error fetching GIFs";
                if (snapshot.hasError) {
                  errorMessage += ": ${snapshot.error}";
                } else if (!snapshot.hasData) {
                  errorMessage = "No GIF found";
                }
                return Text(errorMessage);
              }else {
                return Image.network(snapshot.data!, fit: BoxFit.cover);
              }
            },
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
                  // 여기에서 즐겨찾기 상태를 업데이트하는 로직을 추가할 수 있습니다.
                });
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // 버튼 배경색
              ),
              child: Text('대화 시작'),
              onPressed: () {
                pageNavi.changePage('ChatPage', data: PageData(greeId: widget.gree.id));
              },
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
                  widget.gree.gree_name ?? 'Unknown',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 4), // 간격 추가
                Text(
                  widget.gree.prompt_mbti ?? 'Unknown',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}