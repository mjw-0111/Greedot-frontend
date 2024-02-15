import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:projectfront/widget/design/basicButtons.dart';
import '../../widget/design/settingColor.dart';
import '../../provider/pageNavi.dart';
import '../../models/gree_model.dart';
import '../../service/gree_service.dart';
import '../../screen/user/AdminPage.dart';
import '../../screen/user/ViewProfile.dart';

class RiggingRoot extends StatefulWidget {
  const RiggingRoot({Key? key}) : super(key: key);

  @override
  _RiggingRootState createState() => _RiggingRootState();
}

class _RiggingRootState extends State<RiggingRoot> {
  int activeIndex = 0;
  late Future<List<Gree>> futureGrees;

  @override
  void initState() {
    super.initState();
    futureGrees = ApiServiceGree.readGrees(); // 데이터 로드
  }

  @override
  Widget build(BuildContext context) {
    final pageNavi = Provider.of<PageNavi>(context, listen: false);
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width,
      height: screenSize.height,
      color: colorMainBG_greedot,
      child: FutureBuilder<List<Gree>>(
        future: futureGrees,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            List<Gree> grees = snapshot.data!;
            return Stack(
              children: <Widget>[
                CarouselSlider(
                  items: grees.map((gree) {
                    return Builder(
                      builder: (BuildContext context) {
                        return FlipCard(
                          front: Image.network(gree.raw_img, fit: BoxFit.cover),
                          back: buildCardBack(gree),
                        );
                      },
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 240,
                    viewportFraction: 1.0,
                    autoPlay: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        activeIndex = index;
                      });
                    },
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: AnimatedSmoothIndicator(
                      activeIndex: activeIndex,
                      count: grees.length,
                      effect: SlideEffect(
                        dotHeight: 6,
                        dotWidth: 6,
                        dotColor: Colors.black26,
                        activeDotColor: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 230,
                  left: 0,
                  right: 0,
                  child: Text(
                      "캐릴터를 터치하면 캐릭터 정보가 보여요!",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: colorSnackBar_greedot, fontSize: 15)
                  ),
                ),
                Positioned(
                  bottom: 50,
                  left: 0,
                  right: 170,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(height: 35),
                      Big_EleButton_greedot(
                        additionalFunc: () => pageNavi.changePage('FavoriteListPage'),
                        buttonText: "AI 친구들 모아보기",
                      ),
                      const SizedBox(height: 15),
                      Big_EleButton_greedot(
                        additionalFunc: () => pageNavi.changePage('SkeletonCanvas'),
                        buttonText: "우리아이 대화 보기",
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 50,
                  left: 170,
                  right: 0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(height: 35),
                      Big_EleButton_greedot(
                        additionalFunc: () => pageNavi.changePage('newgree'),
                        buttonText: "그리 새로 만들기",
                      ),
                      const SizedBox(height: 15),
                      Big_EleButton_greedot(
                        additionalFunc: () => pageNavi.changePage('SkeletonCanvas'),
                        buttonText: "같이 게임하기",
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(child: Text("No Gree data available."));
          }
        },
      ),
    );
  }
}

Widget buildCardBack(Gree gree) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('이름: ${gree.gree_name ?? '없음'}', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('성별: ${gree.prompt_jender ?? '없음'}'),
        Text('나이: ${gree.prompt_age ?? '없음'}'),
        Text('성격: ${gree.prompt_mbti ?? '없음'}'),
      ],
    ),
  );
}
