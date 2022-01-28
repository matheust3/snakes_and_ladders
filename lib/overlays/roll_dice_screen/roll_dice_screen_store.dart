import 'dart:ffi';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flutter_snakes_and_ladders/core/failures.dart';
import 'package:flutter_snakes_and_ladders/core/injection_container.dart';
import 'package:flutter_snakes_and_ladders/game/game_store.dart';
import 'package:flutter_triple/flutter_triple.dart';

part 'roll_dice_screen_state.dart';

class RollDiceScreenStore extends NotifierStore<Failure, RollDiceScreenState> {
  RollDiceScreenStore()
      : animationController = _SimpleAnimations(),
        super(const RollDiceScreenState(
          rollDices: false,
          diceValue1: 0,
          diceValue2: 0,
          showDices: false,
        )) {
    animationController.onCompleted = (animationName) {
      if (animationName == 'roll') {
        showDices();
      }
    };
  }

  final _SimpleAnimations animationController;

  Future<void> rollDices() async {
    update(state.copyWith(rollDices: true, showDices: false));
  }

  Future<void> showDices() async {
    _getDicesValues();
    update(state.copyWith(rollDices: false, showDices: true));
    await Future.delayed(const Duration(seconds: 2));
    sl<GameStore>().play();
  }

  // Randomly set values ​​for indices
  void _getDicesValues() {
    final rng = Random();
    final dice1Value = rng.nextInt(6) + 1;
    final dice2Value = rng.nextInt(6) + 1;
    update(state.copyWith(diceValue1: dice1Value, diceValue2: dice2Value));
  }
}

class _SimpleAnimations extends FlareController {
  FlutterActorArtboard? _artboard;

  late String _animationName;
  final double _mixSeconds = 0.1;

  final List<FlareAnimationLayer> _animationLayers = [];

  @override
  void initialize(FlutterActorArtboard artboard) {
    _artboard = artboard;
  }

  void Function(String name)? onCompleted;

  void play(String name, {double mix = 1.0, double mixSeconds = 0.2}) {
    _animationName = name;
    if (_artboard != null) {
      var animation = _artboard!.getAnimation(_animationName);
      if (animation != null) {
        _animationLayers.add(FlareAnimationLayer(_animationName, animation)
          ..mix = mix
          ..mixSeconds = mixSeconds);
        isActive.value = true;
      }
    }
  }

  @override
  void setViewTransform(Mat2D viewTransform) {}

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    assert(artboard == _artboard);

    /// List of completed animations during this frame.
    List<FlareAnimationLayer> completed = [];

    /// This loop will mix all the currently active animation layers so that,
    /// if an animation is played on top of the current one, it'll smoothly mix
    ///  between the two instead of immediately switching to the new one.
    for (int i = 0; i < _animationLayers.length; i++) {
      FlareAnimationLayer layer = _animationLayers[i];
      layer.mix += elapsed;
      layer.time += elapsed;

      double mix = _mixSeconds == 0.0 ? 1.0 : min(1.0, layer.mix / _mixSeconds);

      /// Loop the time if needed.
      if (layer.animation.isLooping) {
        layer.time %= layer.animation.duration;
      }

      /// Apply the animation with the current mix.
      layer.animation.apply(layer.time, artboard, mix);

      /// Add (non-looping) finished animations to the list.
      if (layer.time > layer.animation.duration) {
        completed.add(layer);
      }
    }

    /// Notify of the completed animations.
    for (final FlareAnimationLayer animation in completed) {
      _animationLayers.remove(animation);
      if (onCompleted != null) {
        onCompleted!(animation.name);
      }
    }
    return _animationLayers.isNotEmpty;
  }
}
