import 'package:flutter/material.dart';
import '../gree/addFavorite.dart';
import 'addFavorite.dart';
import '../../widget/design/settingColor.dart';
import 'keepItem.dart';


class FavoriteListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    List<Widget> items = favoriteItems.map((item) {
      return FavoriteItemCard(
        image: item.image,
        name: item.name,
        mbti: item.mbti,
        description: item.description,
      );
    }).toList();

    return Container(
      color: colorMainBG_greedot,
      child: GridView.count(
        crossAxisCount: 2,
        children: items,
      ),
    );
  }
}
