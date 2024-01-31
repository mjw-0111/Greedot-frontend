import 'package:flutter/material.dart';
import '../../widget/addFavorite.dart';
import '../../widget/design/settingColor.dart';
import 'keepItem.dart';


class FavoriteListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // List<Widget> items = [
    //   FavoriteItemCard (image : 'assets/images/gree.png', name: 'gree', mbti: 'INFP',description: '안녕하세요!! 어쩌고 저쩌고'),
    //   FavoriteItemCard (image : 'assets/images/greegirl_3.png', name: 'greegirl_3', mbti: 'ISTJ',description: '안녕하세요!! 어쩌고 저쩌고. 만나서 반가워'),
    //   FavoriteItemCard (image : 'assets/images/gree_2.png', name: 'gree_2', mbti: 'ENFP',description: '안녕하세요!! 어쩌고 저쩌고'),
    //
    // ];

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
