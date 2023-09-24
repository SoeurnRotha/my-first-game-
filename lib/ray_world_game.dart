import 'dart:async';
import 'package:build_game/components/player.dart';
import 'package:build_game/components/world.dart';
import 'package:build_game/components/world_collidable.dart';
import 'package:build_game/helper/direction.dart';
import 'package:build_game/helper/map_load.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/services/keyboard_key.g.dart';

class RayWorldGame extends FlameGame
    with HasCollisionDetection, KeyboardEvents {
  final Player _player = Player();
  final WorldGame _world = WorldGame();
  @override
  FutureOr<void> onLoad() async {
    await add(_world);
    await add(_player);
    addWorldCollision();
    _player.position = _world.size / 2;
    return super.onLoad();
  }

  void onJoypadDirectionChanged(Direction direction) {
    _player.direction = direction;
  }

  @override
  void render(Canvas canvas) {
    final cameraX = _player.x - size.x / 2;
    final cameraY = _player.y - size.y / 2;
    canvas.translate(-cameraX, -cameraY);
    super.render(canvas);
  }

  @override
  KeyEventResult onKeyEvent(
      RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isKeyDown = event is RawKeyDownEvent;
    Direction? keyDirection = null;

    //TODO 1

    if (event.logicalKey == LogicalKeyboardKey.keyA) {
      keyDirection = Direction.left;
    } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
      keyDirection = Direction.right;
    } else if (event.logicalKey == LogicalKeyboardKey.keyW) {
      keyDirection = Direction.up;
    } else if (event.logicalKey == LogicalKeyboardKey.keyS) {
      keyDirection = Direction.down;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      keyDirection = Direction.left;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      keyDirection = Direction.right;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      keyDirection = Direction.down;
    } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      keyDirection = Direction.up;
    }

    //TODO 2

    if (isKeyDown && keyDirection != null) {
      _player.direction = keyDirection;
    } else if (_player.direction == keyDirection) {
      _player.direction = Direction.none;
    }

    return super.onKeyEvent(event, keysPressed);
  }

  void addWorldCollision() async {
    (await MapLoader.readRayWorldCollisionMap()).forEach((rect) {
      add(WorldCollidable()
        ..position = Vector2(rect.left, rect.top)
        ..width = rect.width
        ..height = rect.height);
    });
  }
}
