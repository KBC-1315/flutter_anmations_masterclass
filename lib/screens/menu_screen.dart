import 'package:flutter/material.dart';
import 'package:flutter_anmations_masterclass/screens/apple_watch_screen.dart';
import 'package:flutter_anmations_masterclass/screens/explicit_animations_screen.dart';
import 'package:flutter_anmations_masterclass/screens/explicit_animations_screen2.dart';
import 'package:flutter_anmations_masterclass/screens/implicit_animations_screen.dart';
import 'package:flutter_anmations_masterclass/screens/music_player_screen.dart';
import 'package:flutter_anmations_masterclass/screens/swiping_card_screen.dart';
import 'package:flutter_anmations_masterclass/screens/swiping_card_screen_2.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  void _goToPage(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Flutter Animations",
          ),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () =>
                    _goToPage(context, const ImplicitAnimationsScreen()),
                child: const Text(
                  "Implicit Animations",
                ),
              ),
              ElevatedButton(
                onPressed: () =>
                    _goToPage(context, const ExplicitAnimationsScreen()),
                child: const Text(
                  "Explicit Animations",
                ),
              ),
              ElevatedButton(
                onPressed: () =>
                    _goToPage(context, const ExplicitAnimationsScreen2()),
                child: const Text(
                  "Explicit Animations-2",
                ),
              ),
              ElevatedButton(
                onPressed: () => _goToPage(context, const AppleWatchScreen()),
                child: const Text(
                  "AppleWatch",
                ),
              ),
              ElevatedButton(
                onPressed: () => _goToPage(context, const SwipingCardScreen()),
                child: const Text(
                  "Swiping Card",
                ),
              ),
              ElevatedButton(
                onPressed: () => _goToPage(context, const SwipingCardScreen2()),
                child: const Text(
                  "Swiping Card2",
                ),
              ),
              ElevatedButton(
                onPressed: () => _goToPage(context, const MusicPlayerScreen()),
                child: const Text(
                  "Music Player Screen",
                ),
              ),
            ],
          ),
        ));
  }
}
