import 'package:build_game/helper/joypad.dart';
import 'package:build_game/ray_world_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class MainGameState extends StatefulWidget {
  const MainGameState({super.key});

  @override
  State<MainGameState> createState() => _MainGameStateState();
}

class _MainGameStateState extends State<MainGameState> {
  @override
  Widget build(BuildContext context) {
    RayWorldGame game = RayWorldGame();
    return Scaffold(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
        body: Stack(
          children: [
            GameWidget(game: game),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Joypad(
                  onDirectionChanged: game.onJoypadDirectionChanged,
                ),
              ),
            )
          ],
        ));
  }
}
