import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter_snakes_and_ladders/core/injection_container.dart';
import 'package:flutter_snakes_and_ladders/game/game_store.dart';
import 'package:flutter_snakes_and_ladders/overlays/game_ui/game_ui_store.dart';

class CobrasEscadas extends FlameGame with HasTappables {
  final GameStore gameStore = sl();
  @override
  Future<void>? onLoad() async {
    gameStore.game = this;
    sl<GameUiStore>().game = this;
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
    final lastPosition = gameStore.state.isBlueTurn ? gameStore.state.bluePlayerPosition : gameStore.state.redPlayerPosition;
    final nextPosition = gameStore.state.isBlueTurn ? gameStore.state.bluePlayerPosition + dado1 + dado2 : gameStore.state.redPlayerPosition + dado1 + dado2;
    // Spawna o avatar do jogado se ele esta na posicao zero
    if (dado1 + dado2 == nextPosition) {
      if (gameStore.state.isBlueTurn) {
        gameStore.avatarBlue.position = boardToPosition(0);
        add(gameStore.avatarBlue);
      } else {
        gameStore.avatarRed.position = boardToPosition(0);
        add(gameStore.avatarRed);
      }
    }

    // Salva a posicao do jogador
    if (gameStore.state.isBlueTurn) {
      gameStore.setBluePlayerPosition(nextPosition);
    } else {
      gameStore.setRedPlayerPosition(nextPosition);
    }
  }

  Vector2 boardToPosition(int boardPosition) {
    final boardSteps = Vector2((size.x - 10) / 10, size.y * 0.7 / 10);
    final boardZeros = Vector2(5 + boardSteps.x / 2, 40 + size.y * 0.7 - boardSteps.y / 2);

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
