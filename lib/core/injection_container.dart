import 'package:flutter_snakes_and_ladders/game/game_store.dart';
import 'package:flutter_snakes_and_ladders/overlays/alert_screen/alert_screen_store.dart';
import 'package:flutter_snakes_and_ladders/overlays/game_ui/game_ui_store.dart';
import 'package:flutter_snakes_and_ladders/overlays/roll_dice_screen/roll_dice_screen_store.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => GameStore());
  sl.registerLazySingleton(() => RollDiceScreenStore());
  sl.registerLazySingleton(() => GameUiStore(rollDiceScreenStore: sl()));
  sl.registerLazySingleton(() => AlertScreenStore());
}
