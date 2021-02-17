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
        return Text("no data yet");
      },
    );
  }

  Widget View(PITesterViewState viewState) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leading: Text("pi Tester"),
        title: Column(
          children: [Text("Current Digit"), Text(viewState.currentDigit)],
        ),
        actions: [
          ElevatedButton(onPressed: reset, child: Text("Reset")),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  viewState.displayNumber,
                  style: TextStyle(fontSize: 20.0, color: Colors.amberAccent),
                ),
              ),
            ),
            DigitKeypad(pressedKey),
          ],
        ),
      ),
    );
  }

  pressedKey(int keyNumber) {
    piTesterBloc.processInput(PressedKey(keyNumber));
  }

  reset() {
    piTesterBloc.processInput(ResetIntent());
  }
}
