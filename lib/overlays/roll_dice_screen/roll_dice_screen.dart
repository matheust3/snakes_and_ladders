import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snakes_and_ladders/core/failures.dart';
import 'package:flutter_snakes_and_ladders/overlays/roll_dice_screen/roll_dice_screen_store.dart';
import 'package:flutter_triple/flutter_triple.dart';

class RollDiceScreen extends StatefulWidget {
  const RollDiceScreen(this.rollDiceScreenStore, {Key? key}) : super(key: key);

  final RollDiceScreenStore rollDiceScreenStore;

  @override
  _RollDiceScreenState createState() => _RollDiceScreenState();
}

class _RollDiceScreenState extends State<RollDiceScreen> {
  late final RollDiceScreenStore store;

  @override
  void initState() {
    store = widget.rollDiceScreenStore;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: ScopedBuilder<RollDiceScreenStore, Failure, RollDiceScreenState>(
        store: store,
        onState: (context, state) {
          if (state.rollDices) {
            return Center(
              child: FlareActor(
                'assets/flare/roll dice.flr',
                controller: store.animationController,
                animation: 'static',
                callback: (String animation) {
                  if (animation == 'roll') {
                    store.showDices();
                  } else if (animation == 'static') {
                    store.animationController.play('roll');
                  }
                },
              ),
            );
          } else if (state.showDices) {
            return Center(
              child: Row(
                children: [
                  Flexible(child: Image.asset('assets/images/dice_${state.diceValue1}.png')),
                  Flexible(child: Image.asset('assets/images/dice_${state.diceValue2}.png')),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
