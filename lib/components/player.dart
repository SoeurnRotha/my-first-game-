import 'dart:async';

import 'package:build_game/components/world_collidable.dart';
import 'package:build_game/helper/direction.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class Player extends SpriteAnimationComponent
    with HasGameRef, CollisionCallbacks {
  Player()
      : super(
          size: Vector2.all(50.00),
        ) {
    add(RectangleHitbox());
  }
  Direction direction = Direction.none;
  Direction _collisionDirection = Direction.none;
  bool _hasCollided = false;

  final double _playerSpeed = 300.0;
  final double _animationSpeed = 0.15;

  //animation for controll player lefe , right , up , down

  late final SpriteAnimation _runDownAnimation;
  late final SpriteAnimation _runUpAnimation;
  late final SpriteAnimation _runLeftAnimation;
  late final SpriteAnimation _runRightAnimation;
  late final SpriteAnimation _startingAnimation;

  @override
  FutureOr<void> onLoad() async {
    await _loadAnimations().then((_) => {animation = _startingAnimation});
    position = gameRef.size / 2;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    movePlayer(dt);

    super.update(dt);
  }

  void movePlayer(double delta) {
    switch (direction) {
      case Direction.none:
        animation = _startingAnimation;
        break;
      case Direction.down:
        if (canPlayerMoveDown()) {
          animation = _runDownAnimation;
          moveDown(delta);
        }
        break;
      case Direction.up:
        if (canPlayerMoveUp()) {
          animation = _runUpAnimation;
          moveUp(delta);
        }

        break;
      case Direction.left:
        if (canPlayerMoveLeft()) {
          animation = _runLeftAnimation;
          moveLeft(delta);
        }
        break;
      case Direction.right:
        if (canPlayerMoveRight()) {
          animation = _runRightAnimation;
          moveRight(delta);
        }
        break;
    }
  }

  void moveDown(double dt) {
    position.add(Vector2(0, dt * _playerSpeed));
  }

  void moveUp(double dt) {
    position.add(Vector2(0, dt * -_playerSpeed));
  }

  void moveLeft(double dt) {
    position.add(Vector2(dt * -_playerSpeed, 0));
  }

  void moveRight(double dt) {
    position.add(Vector2(dt * _playerSpeed, 0));
  }

  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: await game.images.load('player_spritesheet.png'),
      srcSize: Vector2(29, 30),
    );

    _runDownAnimation = spriteSheet.createAnimation(
      row: 0,
      stepTime: _animationSpeed,
      to: 4,
    );

    _runLeftAnimation = spriteSheet.createAnimation(
      row: 1,
      stepTime: _animationSpeed,
      to: 4,
    );

    _runUpAnimation = spriteSheet.createAnimation(
      row: 2,
      stepTime: _animationSpeed,
      to: 4,
    );

    _runRightAnimation = spriteSheet.createAnimation(
      row: 3,
      stepTime: _animationSpeed,
      to: 4,
    );

    _startingAnimation = spriteSheet.createAnimation(
      row: 0,
      stepTime: _animationSpeed,
      to: 1,
    );
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is WorldCollidable) {
      if (!_hasCollided) {
        _hasCollided = true;
        _collisionDirection = direction;
      }
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    _hasCollided = false;
    super.onCollisionEnd(other);
  }

  bool canPlayerMoveUp() {
    if (_hasCollided && _collisionDirection == Direction.up) {
      return false;
    }
    return true;
  }

  bool canPlayerMoveDown() {
    if (_hasCollided && _collisionDirection == Direction.down) {
      return false;
    }
    return true;
  }

  bool canPlayerMoveLeft() {
    if (_hasCollided && _collisionDirection == Direction.left) {
      return false;
    }
    return true;
  }

  bool canPlayerMoveRight() {
    if (_hasCollided && _collisionDirection == Direction.right) {
      return false;
    }
    return true;
  }
}
