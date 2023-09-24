import 'package:build_game/main_game_state.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  runApp(const MyFirstGame());
}

class MyFirstGame extends StatelessWidget {
  const MyFirstGame({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainGameState(),
    );
  }
}
