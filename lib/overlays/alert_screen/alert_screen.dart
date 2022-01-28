import 'package:flutter/material.dart';
import 'package:flutter_snakes_and_ladders/core/failures.dart';
import 'package:flutter_snakes_and_ladders/core/injection_container.dart';
import 'package:flutter_snakes_and_ladders/overlays/alert_screen/alert_screen_store.dart';
import 'package:flutter_triple/flutter_triple.dart';

class AlertScreen extends StatefulWidget {
  const AlertScreen({Key? key}) : super(key: key);

  @override
  _AlertScreenState createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  late final AlertScreenStore store;

  @override
  void initState() {
    store = sl<AlertScreenStore>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<AlertScreenStore, Failure, AlertScreenState>(
      store: store,
      onState: (context, state) {
        if (state.showSnakeMessage) {
          return Container(
            color: Colors.black87,
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        'Ohh não',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 30,
                        ),
                      ),
                      Text('uma cobra!!'),
                    ],
                  ),
                ),
                Positioned.fill(
                  bottom: 70,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      child: const Text('Continuar'),
                      onPressed: () => store.showSnakeMessage(false),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
