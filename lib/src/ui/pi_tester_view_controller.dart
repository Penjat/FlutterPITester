import 'package:flutter/material.dart';
import 'package:reactive_pi_tester/src/blocs/pi_tester_bloc.dart';
import 'package:reactive_pi_tester/src/ui/Keypad.dart';

class PITesterViewController extends StatelessWidget {
  PITesterViewController(this.piTesterBloc);

  PITesterBloc piTesterBloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: piTesterBloc.viewState,
      builder: (context, AsyncSnapshot<PITesterViewState> snapshot) {
        if (snapshot.hasData) {
          return PITesterView();
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return ElevatedButton(
            onPressed: keyPressed, child: Text("no data yet"));
      },
    );
  }

  void keyPressed() {
    piTesterBloc.processInput(PressedKey(4));
  }
}

class PITesterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("top text"),
          Expanded(child: Text("Middle text"),),
          DigitKeypad(),
        ],
      ),
    );
  }
}
