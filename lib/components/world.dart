import 'dart:async';

import 'package:flame/components.dart';

class WorldGame extends SpriteComponent with HasGameRef {
  @override
  FutureOr<void> onLoad() async {
    sprite = await gameRef.loadSprite('rayworld_background.png');
    size = sprite!.originalSize;
    return super.onLoad();
  }
}
