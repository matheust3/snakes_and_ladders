import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flutter_snakes_and_ladders/core/injection_container.dart';
import 'package:flutter_snakes_and_ladders/game/game_store.dart';
import 'package:flutter_snakes_and_ladders/game_effects/jump_effect.dart';
import 'package:flutter_snakes_and_ladders/overlays/game_ui/game_ui_store.dart';

class CobrasEscadas extends FlameGame with HasTappables {
  final GameStore gameStore = sl();
  Vector2 boardSteps = Vector2(0, 0);
  Vector2 boardZeros = Vector2(0, 0);

  @override
  Future<void>? onLoad() async {
    gameStore.game = this;
    sl<GameUiStore>().game = this;
    // Medidas do tabuleiro
    boardSteps = Vector2((size.x - 10) / 10, size.y * 0.7 / 10);
    boardZeros = Vector2(5 + boardSteps.x / 2, 40 + size.y * 0.7 - boardSteps.y / 2);
    //Image de fundo
    SpriteComponent background = SpriteComponent()
      ..sprite = await loadSprite('imagem_de_fundo.png')
      ..size = size;
    // Tabuleiro
    SpriteComponent board = SpriteComponent()
      ..anchor = Anchor.topCenter
      ..sprite = await loadSprite('tabuleiro.png')
      ..size = Vector2(size.x - 10, size.y * 0.7)
      ..position = Vector2(size.x * 0.5, 40);

    // Avatares
    sl<GameStore>().avatarRed = SpriteComponent()
      ..anchor = Anchor.bottomCenter
      ..sprite = await loadSprite('avatar_red.png')
      ..size = Vector2(size.x * 0.05, size.y * 0.035)
      ..position = Vector2(size.x * 0.5, 40);
    sl<GameStore>().avatarBlue = SpriteComponent()
      ..anchor = Anchor.bottomCenter
      ..sprite = await loadSprite('avatar_blue.png')
      ..size = Vector2(size.x * 0.05, size.y * 0.035)
      ..position = Vector2(size.x * 0.5, 40);

    add(background);
    add(board);

    return await super.onLoad();
  }

  Future<void> jogar(int dado1, int dado2) async {
    overlays.remove('roll_dices_screen');
    // A proxima posicao
    int lastPosition = gameStore.state.isBlueTurn ? gameStore.state.bluePlayerPosition : gameStore.state.redPlayerPosition;
    final nextPosition = gameStore.state.isBlueTurn ? gameStore.state.bluePlayerPosition + dado1 + dado2 : gameStore.state.redPlayerPosition + dado1 + dado2;
    // Spawna o avatar do jogado se ele esta na posicao zero
    if (dado1 + dado2 == nextPosition) {
      lastPosition = 1;
      if (gameStore.state.isBlueTurn) {
        gameStore.avatarBlue.position = boardToPosition(1);
        add(gameStore.avatarBlue);
      } else {
        gameStore.avatarRed.position = boardToPosition(1);
        add(gameStore.avatarRed);
      }
    }
    // Move o avatar do jogador, casa por casa
    for (int i = lastPosition + 1; i <= nextPosition; i++) {
      if (gameStore.state.isBlueTurn) {
        final JumpEffect jumpEffect = JumpEffect(gameStore.avatarBlue.position, boardToPosition(i), -boardSteps.y, EffectController(duration: 0.7));
        gameStore.avatarBlue.add(jumpEffect);
      } else {
        final JumpEffect jumpEffect = JumpEffect(gameStore.avatarRed.position, boardToPosition(i), -boardSteps.y, EffectController(duration: 0.7));
        gameStore.avatarRed.add(jumpEffect);
      }
      await Future.delayed(const Duration(seconds: 1));
    }
    // Salva a posicao do jogador
    if (gameStore.state.isBlueTurn) {
      gameStore.setBluePlayerPosition(nextPosition);
    } else {
      gameStore.setRedPlayerPosition(nextPosition);
    }
    // Ajusta os avatares se os dois jogadores estiverem na msm posicao
    if (gameStore.state.redPlayerPosition == gameStore.state.bluePlayerPosition) {
      gameStore.avatarRed.add(MoveEffect.to(gameStore.avatarRed.position + (boardSteps / 4), EffectController(duration: 0.7)));
      gameStore.avatarBlue.add(MoveEffect.to(gameStore.avatarBlue.position - (boardSteps / 4), EffectController(duration: 0.7)));
      await Future.delayed(const Duration(seconds: 1));
    }
    // Se os dados forem nao forem iguais, passa vez
    if (dado1 != dado2) {
      gameStore.setBlueTurn(!gameStore.state.isBlueTurn);
    }
  }

  Vector2 boardToPosition(int boardPosition) {
    //Calcula a posicao cartesiana com base na casa do tabuleiro
    final y = boardPosition ~/ 10;
    final x = boardPosition % 10;

    //Mapeando as coordenadas cartesianas para o tabuleiro
    late Vector2 screenPosition;
    final deltaY = x == 0 ? (boardSteps.y * (y - 1)) : (boardSteps.y * y);
    if (y % 2 == 0) {
      final deltaX = x > 0 ? (boardSteps.x * (x - 1)) : 0;
      screenPosition = Vector2(boardZeros.x + deltaX, boardZeros.y - deltaY);
    } else {
      final deltaX = x > 0 ? (boardSteps.x * (10 - x)) : boardSteps.x * 9;
      screenPosition = Vector2(boardZeros.x + deltaX, boardZeros.y - deltaY);
    }
    return screenPosition;
  }
}
