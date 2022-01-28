import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flutter_snakes_and_ladders/core/injection_container.dart';
import 'package:flutter_snakes_and_ladders/game/game_store.dart';
import 'package:flutter_snakes_and_ladders/game_effects/jump_effect.dart';
import 'package:flutter_snakes_and_ladders/overlays/game_ui/game_ui_store.dart';

class CobrasEscadas extends FlameGame with HasTappables {
  final GameStore gameStore = sl();
  // Mapa contendo a cabeca e a calda das cobras
  final Map<int, int> snakeHeadMap = {16: 6, 49: 11, 46: 25, 62: 19, 64: 60, 74: 53, 89: 68, 92: 88, 95: 75, 99: 80};
  final Map<int, int> laddersMap = {2: 38, 7: 14, 8: 31, 15: 26, 21: 42, 28: 84, 36: 44, 51: 67, 78: 98, 71: 91, 87: 94};
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
    if (gameStore.state.movingAvatar) return;
    gameStore.setMovingAvatar(true);
    overlays.remove('roll_dices_screen');
    // A proxima posicao
    int lastPosition = gameStore.state.isBlueTurn ? gameStore.state.bluePlayerPosition : gameStore.state.redPlayerPosition;
    int nextPosition = gameStore.state.isBlueTurn ? gameStore.state.bluePlayerPosition + dado1 + dado2 : gameStore.state.redPlayerPosition + dado1 + dado2;
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
      int currentPosition = i;
      if (currentPosition > 100) {
        currentPosition = 100 - (currentPosition - 100);
      }
      if (gameStore.state.isBlueTurn) {
        sl<GameUiStore>().setBluePosition(currentPosition);
        final JumpEffect jumpEffect = JumpEffect(gameStore.avatarBlue.position, boardToPosition(currentPosition), -boardSteps.y, EffectController(duration: 0.7));
        gameStore.avatarBlue.add(jumpEffect);
      } else {
        sl<GameUiStore>().setRedPosition(currentPosition);
        final JumpEffect jumpEffect = JumpEffect(gameStore.avatarRed.position, boardToPosition(currentPosition), -boardSteps.y, EffectController(duration: 0.7));
        gameStore.avatarRed.add(jumpEffect);
      }
      await Future.delayed(const Duration(seconds: 1));
    }
    // Ajusta a posicao se ela for maior que 100
    if (nextPosition > 100) {
      nextPosition = 100 - (nextPosition - 100);
    }
    // Salva a posicao do jogador
    if (gameStore.state.isBlueTurn) {
      gameStore.setBluePlayerPosition(nextPosition);
    } else {
      gameStore.setRedPlayerPosition(nextPosition);
    }
    // Checa se encontrou a cabeca de uma cobra
    if (snakeHeadMap.containsKey(nextPosition)) {
      if (gameStore.state.isBlueTurn) {
        gameStore.avatarBlue.add(MoveEffect.to(boardToPosition(snakeHeadMap[nextPosition]!), EffectController(duration: 1)));
        gameStore.setBluePlayerPosition(snakeHeadMap[nextPosition]!);
      } else {
        gameStore.avatarRed.add(MoveEffect.to(boardToPosition(snakeHeadMap[nextPosition]!), EffectController(duration: 1)));
        gameStore.setRedPlayerPosition(snakeHeadMap[nextPosition]!);
      }
    }
    // Checa se encontrou a base de uma escada
    if (laddersMap.containsKey(nextPosition)) {
      if (gameStore.state.isBlueTurn) {
        gameStore.avatarBlue.add(MoveEffect.to(boardToPosition(laddersMap[nextPosition]!), EffectController(duration: 1)));
        gameStore.setBluePlayerPosition(laddersMap[nextPosition]!);
      } else {
        gameStore.avatarRed.add(MoveEffect.to(boardToPosition(laddersMap[nextPosition]!), EffectController(duration: 1)));
        gameStore.setRedPlayerPosition(laddersMap[nextPosition]!);
      }
    }
    // Ajusta os avatares se os dois jogadores estiverem na msm posicao
    if (gameStore.state.redPlayerPosition == gameStore.state.bluePlayerPosition) {
      gameStore.avatarRed.add(MoveEffect.to(gameStore.avatarRed.position + (boardSteps / 4), EffectController(duration: 0.7)));
      gameStore.avatarBlue.add(MoveEffect.to(gameStore.avatarBlue.position - (boardSteps / 4), EffectController(duration: 0.7)));
      await Future.delayed(const Duration(seconds: 1));
    }
    // Seta a posicao final (pode ter subido uma escada ou engolido por uma cobra)
    if (gameStore.state.isBlueTurn) {
      sl<GameUiStore>().setBluePosition(gameStore.state.bluePlayerPosition);
    } else {
      sl<GameUiStore>().setRedPosition(gameStore.state.redPlayerPosition);
    }
    // Se os dados forem nao forem iguais, passa vez
    if (dado1 != dado2) {
      gameStore.setBlueTurn(!gameStore.state.isBlueTurn);
      sl<GameUiStore>().setBlueTurn(gameStore.state.isBlueTurn);
    }
    gameStore.setMovingAvatar(false);
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
