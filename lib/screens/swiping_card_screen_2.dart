import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SwipingCardScreen2 extends StatefulWidget {
  const SwipingCardScreen2({super.key});

  @override
  State<SwipingCardScreen2> createState() => _SwipingCardScreenState2();
}

class _SwipingCardScreenState2 extends State<SwipingCardScreen2>
    with SingleTickerProviderStateMixin {
  late final size = MediaQuery.of(context).size;
  late final AnimationController _position = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      lowerBound: (size.width + 100) * (-1),
      upperBound: (size.width + 100),
      value: 0.0);
  double posX = 0;

  late final Tween<double> _rotation = Tween(begin: -15, end: 15);

  late final Tween<double> _scale = Tween(begin: 0.8, end: 1.0);

  late final ColorTween _lColor =
      ColorTween(begin: Colors.blue, end: Colors.green);
  late final ColorTween _rColor =
      ColorTween(begin: Colors.blue, end: Colors.red.shade400);

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    _position.value += details.delta.dx;
  }

  void _whenComplete() {
    _position.value = 0;
    setState(() {
      _index = _index == 5 ? 1 : _index + 1;
      _isFront = true;
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    final bound = size.width - 200;
    final dropZone = size.width + 100;
    if (_position.value.abs() >= bound) {
      if (_position.value.isNegative) {
        _position.animateTo((dropZone) * -1).whenComplete(() {
          _whenComplete();
        });
      } else {
        _position.animateTo(dropZone).whenComplete(() {
          _whenComplete();
        });
      }
    } else {
      _position.animateTo(0, curve: Curves.easeOut);
    }
  }

  @override
  void dispose() {
    _position.dispose();
    super.dispose();
  }

  int _index = 1;
  bool _isFront = true;

  void _flipCard() {
    setState(() {
      _isFront = !_isFront;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Swiping Cards"),
      ),
      body: AnimatedBuilder(
        animation: _position,
        builder: (context, child) {
          final angle = _rotation
              .transform((_position.value + size.width / 2) / size.width);
          final scale = _scale.transform(_position.value.abs() / size.width);
          final backgroundColor = (!_position.value.isNegative)
              ? _lColor.transform(_position.value.abs() * 2)
              : _rColor.transform(_position.value.abs());

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            color: backgroundColor,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                    top: 50,
                    child: Text(
                        _position.value.isNegative
                            ? "I don't know him"
                            : "I know him",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: (_position.value == 0)
                                ? Colors.blue
                                : Colors.black))),
                Positioned(
                  top: 100,
                  child: Transform.scale(
                      scale: min(scale, 1.5),
                      child: SwipableCard(index: _index == 5 ? 1 : _index + 1)),
                ),
                Positioned(
                  top: 100,
                  child: GestureDetector(
                    onHorizontalDragUpdate: _onHorizontalDragUpdate,
                    onHorizontalDragEnd: _onHorizontalDragEnd,
                    onTap: _flipCard,
                    child: Transform.translate(
                      offset: Offset(_position.value, 0),
                      child: Transform.rotate(
                          angle: angle * pi / 180,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 800),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              final rotate =
                                  Tween(begin: pi, end: 0.0).animate(animation);
                              return AnimatedBuilder(
                                animation: rotate,
                                child: child,
                                builder: (context, child) {
                                  final isUnder =
                                      (ValueKey(_isFront) != child?.key);
                                  var tilt =
                                      ((animation.value - 0.5).abs() - 0.5) *
                                          0.003;
                                  tilt *= isUnder ? -1.0 : 1.0;
                                  final value = isUnder
                                      ? min(rotate.value, pi / 2)
                                      : rotate.value;
                                  return Transform(
                                    transform: Matrix4.rotationY(value)
                                      ..setEntry(3, 0, tilt),
                                    alignment: Alignment.center,
                                    child: value > pi / 2 && value < pi * 3 / 2
                                        ? const GrayCard()
                                        : child,
                                  );
                                },
                              );
                            },
                            child: _isFront
                                ? SwipableCard(
                                    key: const ValueKey(true),
                                    index: _index,
                                  )
                                : CardBack(
                                    index: _index, key: const ValueKey(false)),
                          )),
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * 0.75,
                  child: CustomPaint(
                    painter: AppleWatchPainter(progress: _index),
                    size: Size(size.width, 20),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class SwipableCard extends StatelessWidget {
  final int index;
  const SwipableCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: size.width * 0.8,
        height: size.height * 0.5,
        child: Image.asset("assets/covers/$index.png", fit: BoxFit.cover),
      ),
    );
  }
}

class CardBack extends StatelessWidget {
  final int index;
  const CardBack({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<String> nameList = ["양현종", "이의리", "장민기", "황동하", "강동훈"];
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: size.width * 0.8,
        height: size.height * 0.5,
        child: Center(
          child: Text(
            nameList[index - 1],
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class GrayCard extends StatelessWidget {
  const GrayCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.grey.shade200,
      elevation: 10,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: size.width * 0.8,
        height: size.height * 0.5,
      ),
    );
  }
}

class AppleWatchPainter extends CustomPainter {
  final int progress;
  AppleWatchPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final lcenter = Offset(size.width * 0.15, size.height * 0.5);
    final rcenter = Offset(size.width * 0.85, size.height * 0.5);

    final greyLinePainter = Paint()
      ..color = Colors.grey.shade400.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(lcenter, rcenter, greyLinePainter);

    final progressPainter = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
        lcenter,
        Offset(
            lcenter.dx + (rcenter.dx - lcenter.dx) * progress / 5, rcenter.dy),
        progressPainter);
  }

  @override
  bool shouldRepaint(covariant AppleWatchPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
