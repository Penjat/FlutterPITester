import 'package:flutter/material.dart';
import 'package:reactive_pi_tester/src/blocs/pi_tester_bloc.dart';
import 'package:reactive_pi_tester/src/ui/digit_keypad.dart';

class PITesterViewController extends StatelessWidget {
  PITesterViewController(this.piTesterBloc);

  PITesterBloc piTesterBloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: piTesterBloc.viewState,
      builder: (context, AsyncSnapshot<PITesterViewState> snapshot) {
        if (snapshot.hasData) {
          return View(snapshot.data);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return ElevatedButton(
            onPressed: pressedKey(9), child: Text("no data yet"));
      },
    );
  }

  Widget View(PITesterViewState viewState) {
    return Center(
      child: Column(
        children: [
          Text("top text"),
          Expanded(
            child: Center(
              child: Text(viewState.displayNumber),
            ),
          ),
          DigitKeypad(pressedKey),
        ],
      ),
    );
  }

  pressedKey(int keyNumber) {
    piTesterBloc.processInput(PressedKey(keyNumber));
  }
}
