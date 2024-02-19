import 'package:flutter/material.dart';
import '../../models/gree_model.dart';
import '../gree/addFavorite.dart';


Widget buildItemTextSection(Gree gree) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Name: ${gree.gree_name ?? 'Unknown'}', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('MBTI: ${gree.prompt_mbti ?? 'Unknown'}'),
        if (gree.prompt_age != null) Text('Age: ${gree.prompt_age}'),
        if (gree.prompt_jender != null) Text('Gender: ${gree.prompt_jender}'),
        // 여기에 필요한 추가 정보를 계속해서 추가할 수 있습니다.
      ],
    ),
  );
}


