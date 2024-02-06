import 'package:flutter/material.dart';

class PersonalityData {
  static final List<String> sexList = ['남자', '여자'];
  static final List<String> ageList = List.generate(20, (index) => (index + 1).toString());
  static final List<List<String>> optionValues = [['I', 'E'], ['N', 'S'], ['F', 'T'], ['P', 'J']];
  static final List<String> questionList = [
    '새로운 놀이 친구를 사귀는 게 좋아, 아니면 친한 친구와 같이 놀기가 더 좋아?',
    '책을 읽을 때, 어떤 이야기가 더 좋아?',
    '친구가 슬픈 이야기를 할 때, 너는 어떻게 할거야?',
    '아침에 일어나서 뭐 할거야?',
  ];
  static final List<List<String>> optionsList = [
    ['새로운 놀이 친구를 사귀는 게 좋아!', ' 친한 친구와 같이 놀기가 더 좋아!'],
    ['마법과 모험이 있는 판타지 이야기가 더 좋아!', '현실 동화나 동물 이야기가 더 좋아!'],
    ['어떻게 도와줄 수 있는지 생각해!', '같이 울거나 위로해주고 싶어!'],
    ['먼저 계획하고 준비할래!', '마음대로 하고 싶은 걸 할래!'],
  ];
}