import 'package:flutter/material.dart';
import 'addFavorite.dart';
import '../../widget/design/settingColor.dart';


List<FavoriteItemCard> favoriteItems = [
  FavoriteItemCard (image : 'assets/images/gree.png', name: 'gree', mbti: 'INFP',description: '안녕하세요!! 어쩌고 저쩌고'),
  FavoriteItemCard (image : 'assets/images/greegirl_3.png', name: 'greegirl_3', mbti: 'ISTJ',description: '안녕하세요!! 어쩌고 저쩌고. 만나서 반가워'),
  FavoriteItemCard (image : 'assets/images/gree_2.png', name: 'gree_2', mbti: 'ENFP',description: '안녕하세요!! 어쩌고 저쩌고'),
];

Widget buildItemTextSection(FavoriteItemCard item) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Name: ${item.name}'),
        Text('MBTI: ${item.mbti}'),
        Text('Description: ${item.description}'),
      ],
    ),
  );
}
