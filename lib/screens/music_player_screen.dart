import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_anmations_masterclass/screens/music_player_detail_screen.dart';
import 'package:flutter_svg/svg.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen>
    with TickerProviderStateMixin {
  bool _absorb = false;
  final PageController _pageController = PageController(
    viewportFraction: 0.8,
  );
  int _currentPage = 0;

  final ValueNotifier<double> _scroll = ValueNotifier(0.0);

  late final AnimationController _menuController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  );

  late final Animation<double> _screenScale =
      Tween(begin: 1.0, end: 0.7).animate(
    CurvedAnimation(
      parent: _menuController,
      curve: const Interval(0.0, 0.2),
    ),
  );

  late final AnimationController detailscreenController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1000));

  late final Animation<double> _dismissArrow = Tween(begin: 1.0, end: 0.0)
      .animate(CurvedAnimation(
          parent: detailscreenController, curve: const Interval(0.0, 0.25)));

  late final Animation<Offset> _readydetailScreenOffset =
      Tween(begin: Offset.zero, end: const Offset(0.0, -0.025)).animate(
          CurvedAnimation(
              parent: detailscreenController,
              curve: const Interval(0.25, 0.5)));

  late final Animation<Offset> _detailscreenOffset =
      Tween(begin: Offset.zero, end: const Offset(0.0, 0.95)).animate(
          CurvedAnimation(
              parent: detailscreenController,
              curve: const Interval(0.5, 0.75)));

  late final Animation<double> _setArrow = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: detailscreenController, curve: const Interval(0.75, 1.0)));

  late final Animation<Offset> _screenOffset =
      Tween(begin: Offset.zero, end: const Offset(0.5, 0)).animate(
    CurvedAnimation(
      parent: _menuController,
      curve: const Interval(0.2, 0.4),
    ),
  );

  late final Animation<double> _closeButtonOpacity = Tween(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(
          parent: _menuController, curve: const Interval(0.6, 1.0)));

  late final Animation<Offset> _menuAnimations =
      Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero).animate(
    CurvedAnimation(
      parent: _menuController,
      curve: const Interval(
        0.4,
        0.6,
        curve: Curves.easeOut,
      ),
    ),
  );

  late final Animation<double> _detailScreenOpacity =
      Tween(begin: 0.0, end: 1.0).animate(detailscreenController);

  void _onPageChange(int newPage) {
    setState(() {
      _currentPage = newPage;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_pageController.page == null) return;
      _scroll.value = _pageController.page!;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _menuController.dispose();
    detailscreenController.dispose();
    super.dispose();
  }

  void _openMenu() {
    _menuController.forward();
  }

  void _closeMenu() {
    _menuController.reverse();
  }

  void _onTap() {
    print("tap");
    setState(() {
      _absorb = true;
    });
    detailscreenController.forward();
  }

  void _closeDetailScreen() {
    print("close");
    setState(() {
      _absorb = false;
    });
    detailscreenController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> teamNameList = [
      "KIA",
      "LG",
      "삼성",
      "두산",
      "KT",
      "NC",
      "롯데",
      "한화",
      "키움",
      "SSG",
    ];
    final List<Map<String, Object>> playerDataList = [
      {
        "name": "양현종",
        "team": "KIA",
        "ERA": 3.82,
        "G": 19,
        "W": 7,
        "L": 3,
        "SV": 0,
        "HLD": 0,
        "WPCT": 0.700,
        "IP": "115 1/3",
        "H": 113,
        "HR": 13,
        "BB": 25,
        "HBP": 4,
        "SO": 82,
        "R": 51,
        "ER": 49,
        "WHIP": 1.20
      },
      {
        "name": "이의리",
        "team": "KIA",
        "ERA": 4.20,
        "G": 18,
        "W": 6,
        "L": 4,
        "SV": 0,
        "HLD": 0,
        "WPCT": 0.600,
        "IP": "100 2/3",
        "H": 105,
        "HR": 10,
        "BB": 30,
        "HBP": 3,
        "SO": 75,
        "R": 45,
        "ER": 42,
        "WHIP": 1.25
      },
      {
        "name": "장민기",
        "team": "KT",
        "ERA": 3.50,
        "G": 15,
        "W": 5,
        "L": 2,
        "SV": 1,
        "HLD": 1,
        "WPCT": 0.714,
        "IP": "90",
        "H": 85,
        "HR": 8,
        "BB": 20,
        "HBP": 2,
        "SO": 60,
        "R": 40,
        "ER": 35,
        "WHIP": 1.15
      },
      {
        "name": "황동하",
        "team": "LG",
        "ERA": 4.50,
        "G": 17,
        "W": 4,
        "L": 5,
        "SV": 0,
        "HLD": 2,
        "WPCT": 0.444,
        "IP": "95 1/3",
        "H": 100,
        "HR": 12,
        "BB": 28,
        "HBP": 5,
        "SO": 70,
        "R": 50,
        "ER": 48,
        "WHIP": 1.30
      },
      {
        "name": "강동훈",
        "team": "NC",
        "ERA": 3.80,
        "G": 16,
        "W": 6,
        "L": 3,
        "SV": 0,
        "HLD": 3,
        "WPCT": 0.667,
        "IP": "105",
        "H": 95,
        "HR": 11,
        "BB": 22,
        "HBP": 4,
        "SO": 78,
        "R": 45,
        "ER": 42,
        "WHIP": 1.18
      }
    ];

    final List<String> nameList = ["양현종", "이의리", "장민기", "황동하", "강동훈"];
    return Stack(
      children: [
        FadeTransition(
          opacity: _closeButtonOpacity,
          child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              leading: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: _closeMenu,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: PageView.builder(
                      clipBehavior: Clip.hardEdge,
                      controller: PageController(viewportFraction: 0.2),
                      scrollDirection: Axis.vertical,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return SlideTransition(
                          position: _menuAnimations,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                width: 100,
                                child: SvgPicture.asset(
                                  (teamNameList[index] == "SSG")
                                      ? "assets/covers/SSG_랜더스.svg"
                                      : "assets/covers/${teamNameList[index]}.svg",
                                  fit: BoxFit.contain,
                                  width: 100,
                                  height: 50,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                teamNameList[index],
                                style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SlideTransition(
          position: _screenOffset,
          child: ScaleTransition(
            scale: _screenScale,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                actions: [
                  IconButton(
                    onPressed: _openMenu,
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.black,
              body: ClipRRect(
                child: Stack(
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: Container(
                        key: ValueKey(_currentPage),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                "assets/covers/${_currentPage + 1}.png"),
                          ),
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 15,
                            sigmaY: 15,
                          ),
                          child: Container(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                    FadeTransition(
                      opacity: _detailScreenOpacity,
                      child: MusicPlayerDetailScreen(
                        dataList: playerDataList,
                        playerName: nameList[_currentPage],
                        index: _currentPage,
                        controller: detailscreenController,
                      ),
                    ),
                    SlideTransition(
                      position: _readydetailScreenOffset,
                      child: SlideTransition(
                        position: _detailscreenOffset,
                        child: GestureDetector(
                          onTap: () {
                            _absorb
                                ? detailscreenController.reverse()
                                : print('hw');
                          },
                          child: Stack(
                            children: [
                              Positioned(
                                  left: !_absorb
                                      ? MediaQuery.of(context).size.width * 0.40
                                      : MediaQuery.of(context).size.width *
                                          0.14,
                                  top: !_absorb
                                      ? MediaQuery.of(context).size.height * 0.2
                                      : 0,
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: !_absorb
                                        ? FadeTransition(
                                            opacity: _dismissArrow,
                                            child: IconButton(
                                              onPressed: _onTap, // 함수 호출을 바로 설정
                                              icon: const Icon(
                                                Icons.arrow_upward_rounded,
                                                color: Colors.transparent,
                                                size: 30,
                                              ),
                                            ),
                                          )
                                        : FadeTransition(
                                            opacity: _setArrow,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                    Icons
                                                        .arrow_downward_rounded,
                                                    color: Colors.white,
                                                    size: 30,
                                                  ),
                                                ),
                                                Container(
                                                  width: 350,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(0.8),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.4),
                                                        blurRadius: 10,
                                                        spreadRadius: 2,
                                                        offset:
                                                            const Offset(0, 8),
                                                      ),
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                  )),
                              PageView.builder(
                                onPageChanged: _onPageChange,
                                controller: _pageController,
                                itemCount: 5,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 30),
                                      ValueListenableBuilder(
                                        valueListenable: _scroll,
                                        builder: (context, scroll, child) {
                                          final difference =
                                              (scroll - index).abs();
                                          final scale = 1 - (difference * 0.1);
                                          return GestureDetector(
                                            onTap: () => _onTap(),
                                            child: Hero(
                                              tag: "{$index+1}",
                                              child: Transform.scale(
                                                scale: scale,
                                                child: Container(
                                                  height: 350,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(0.8),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.4),
                                                        blurRadius: 10,
                                                        spreadRadius: 2,
                                                        offset:
                                                            const Offset(0, 8),
                                                      ),
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          "assets/covers/${index + 1}.png"),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 30),
                                      Text(nameList[index],
                                          style: const TextStyle(
                                            fontSize: 36,
                                            color: Colors.white,
                                          )),
                                      const SizedBox(height: 50),
                                      SizedBox(
                                        width: 200,
                                        child: SvgPicture.asset(
                                          "assets/covers/KIA.svg",
                                          fit: BoxFit.contain,
                                          width: 200,
                                          height: 150,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
