import 'dart:ui';

import 'package:flame/effects.dart';

class JumpEffect extends MoveAlongPathEffect {
  JumpEffect(Vector2 lastPosition, Vector2 nextPosition, double deltaY, EffectController controller)
      : super(
            Path()
              ..quadraticBezierTo(
                  //x1
                  (nextPosition.x - lastPosition.x) / 2,
                  //y1
                  deltaY,
                  //x2
                  nextPosition.x - lastPosition.x,
                  //y2
                  nextPosition.y - lastPosition.y),
            controller);
}
