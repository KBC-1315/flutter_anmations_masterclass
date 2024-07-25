import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MusicPlayerDetailScreen extends StatefulWidget {
  final int index;
  final String playerName;
  final AnimationController controller;
  final List<Map<String, Object>> dataList;
  const MusicPlayerDetailScreen(
      {super.key,
      required this.index,
      required this.controller,
      required this.playerName,
      required this.dataList});

  @override
  State<MusicPlayerDetailScreen> createState() =>
      _MusicPlayerDetailScreenState();
}

class _MusicPlayerDetailScreenState extends State<MusicPlayerDetailScreen>
    with TickerProviderStateMixin {
  late final AnimationController _progressController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 5),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    List<double> randomNumbers =
        List.generate(5, (index) => 0.5 + (random.nextDouble() * 0.5));
    final size = MediaQuery.of(context).size;
    final playerData = widget.dataList[widget.index];

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.center,
                child: Hero(
                  tag: "${widget.index}",
                  child: Container(
                    height: 350,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: const Offset(0, 8)),
                      ],
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image:
                            AssetImage("assets/covers/${widget.index + 1}.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: SizedBox(
                  width: size.width,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 43,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: size.width * 0.3,
                          child: Text(
                            widget.playerName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: SvgPicture.asset(
                            "assets/covers/KIA.svg",
                            fit: BoxFit.contain,
                            width: 100,
                            height: 50,
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.4,
                          child: const Text(
                            "투수",
                            textAlign: TextAlign.center, // 텍스트를 가운데 정렬
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(height: 1, color: Colors.grey.shade300),
              const SizedBox(
                height: 40,
              ),
              AnimatedBuilder(
                animation: widget.controller,
                builder: (context, child) {
                  return CustomPaint(
                    size: Size(size.width - 150, size.height * 0.3),
                    painter: ProgressBar(
                      values: randomNumbers,
                      labels: ["승률", "평균자책점", "경기수", "세이브", "출루허용률"],
                      progress: widget.controller.value,
                    ),
                  );
                },
              ),
              // 여기부터 데이터를 표시
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 팀명
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      margin: const EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "팀: ",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          Text(
                            playerData['team'].toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ERA
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      margin: const EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "ERA: ",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          Text(
                            playerData['ERA'].toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 경기, 승, 패, 세이브 (Row로 배치)
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            margin:
                                const EdgeInsets.only(bottom: 10.0, right: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "경기: ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                Text(
                                  playerData['G'].toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            margin: const EdgeInsets.only(
                                bottom: 10.0, left: 5.0, right: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "승: ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                Text(
                                  playerData['W'].toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            margin: const EdgeInsets.only(
                                bottom: 10.0, left: 5.0, right: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "패: ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                Text(
                                  playerData['L'].toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            margin:
                                const EdgeInsets.only(bottom: 10.0, left: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "세이브: ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                Text(
                                  playerData['SV'].toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    // 홀드, 승률
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            margin:
                                const EdgeInsets.only(bottom: 10.0, right: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "홀드: ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                Text(
                                  playerData['HLD'].toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            margin:
                                const EdgeInsets.only(bottom: 10.0, left: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "승률: ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                Text(
                                  playerData['WPCT'].toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    // 이닝, 피안타, 피홈런
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      margin: const EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "이닝: ",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          Text(
                            playerData['IP'].toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "피안타: ",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          Text(
                            playerData['H'].toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "피홈런: ",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          Text(
                            playerData['HR'].toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 볼넷, 사구, 삼진
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            margin:
                                const EdgeInsets.only(bottom: 10.0, right: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "볼넷: ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                Text(
                                  playerData['BB'].toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            margin: const EdgeInsets.only(
                                bottom: 10.0, left: 5.0, right: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "사구: ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                Text(
                                  playerData['HBP'].toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            margin:
                                const EdgeInsets.only(bottom: 10.0, left: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "삼진: ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                Text(
                                  playerData['SO'].toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    // 실점, 자책점, WHIP
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            margin:
                                const EdgeInsets.only(bottom: 10.0, right: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "실점: ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                Text(
                                  playerData['R'].toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            margin: const EdgeInsets.only(
                                bottom: 10.0, left: 5.0, right: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "자책점: ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                Text(
                                  playerData['ER'].toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            margin:
                                const EdgeInsets.only(bottom: 10.0, left: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "WHIP: ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                Text(
                                  playerData['WHIP'].toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class ProgressBar extends CustomPainter {
  final double centerCircleRadius;
  final List<double> values;
  final List<String> labels;
  final double maxValue;
  final double progress; // 애니메이션 진행 상황

  ProgressBar({
    required this.values,
    required this.labels,
    required this.progress,
    this.centerCircleRadius = 10,
    this.maxValue = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 20;
    final angleIncrement = 2 * pi / values.length;

    // 배경 오각형 그리기
    final backgroundPath = Path();
    for (int i = 0; i < values.length; i++) {
      final angle = i * angleIncrement - pi / 2;
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);
      if (i == 0) {
        backgroundPath.moveTo(x, y);
      } else {
        backgroundPath.lineTo(x, y);
      }
    }
    backgroundPath.close();
    final backgroundPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;
    canvas.drawPath(backgroundPath, backgroundPaint);

    // 중심에서 각 꼭짓점으로의 선 그리기
    final linePaint = Paint()
      ..color = Colors.grey // 색상 조정
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0; // 선 두께 증가
    for (int i = 0; i < values.length; i++) {
      final angle = i * angleIncrement - pi / 2;
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);
      canvas.drawLine(center, Offset(x, y), linePaint);
    }

    // 값 영역 그리기 (애니메이션 적용)
    final valuePath = Path();
    for (int i = 0; i < values.length; i++) {
      final angle = i * angleIncrement - pi / 2;
      final valueRadius =
          radius * (values[i] * progress / maxValue); // 애니메이션 진행 상황 반영
      final x = center.dx + valueRadius * cos(angle);
      final y = center.dy + valueRadius * sin(angle);
      if (i == 0) {
        valuePath.moveTo(x, y);
      } else {
        valuePath.lineTo(x, y);
      }
    }
    valuePath.close();
    final valuePaint = Paint()
      ..color = Colors.blue.withOpacity(0.5)
      ..style = PaintingStyle.fill;
    canvas.drawPath(valuePath, valuePaint);

    // 중심 원 그리기
    canvas.drawCircle(center, centerCircleRadius, valuePaint);

    // 각 꼭짓점에 라벨 그리기
    final labelPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < labels.length; i++) {
      final angle = i * angleIncrement - pi / 2;
      final x = center.dx + (radius + 20) * cos(angle);
      final y = center.dy + (radius + 20) * sin(angle);
      labelPainter.text = TextSpan(
        text: labels[i],
        style: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
      );
      labelPainter.layout();
      final offset =
          Offset(x - labelPainter.width / 2, y - labelPainter.height / 2);
      labelPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
