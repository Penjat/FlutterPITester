import 'package:flutter/material.dart';
import 'package:reactive_pi_tester/src/blocs/pi_tester_bloc.dart';
import 'package:reactive_pi_tester/src/ui/digit_keypad.dart';
import 'package:flutter/animation.dart';

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
          children: [
            Text("Current Digit"),
            AnimatedSwitcher(
              child: Text(viewState.currentDigit,
                  key: ValueKey<String>(viewState.currentDigit)),
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(child: child, scale: animation);
              },
            ),
          ],
        ),
        actions: [
          ElevatedButton(onPressed: reset, child: Text("Reset")),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Stack(children: [
                flashedDigit(viewState.flashDigit),
                Center(
                  child: Text(
                    viewState.displayNumber,
                    key: ValueKey<String>(viewState.displayNumber),
                    style: TextStyle(fontSize: 20.0, color: Colors.amberAccent),
                  ),
                ),
              ]),
            ),
            DigitKeypad(pressedKey),
          ],
        ),
      ),
    );
  }

  Widget flashedDigit(String digit) {
    return digit == null
        ? Container()
        : TweenAnimationBuilder(
            key: ValueKey<String>(digit),
            tween: Tween<double>(begin: 1, end: 0),
            duration: Duration(seconds: 1),
            builder: (context, value, child) {
              return Center(
                  child: Opacity(
                      opacity: value,
                      child: Text(digit,
                          style: TextStyle(fontSize: value * 100))));
            });
  }

  pressedKey(int keyNumber) {
    piTesterBloc.processInput(PressedKey(keyNumber));
  }

  reset() {
    piTesterBloc.processInput(ResetIntent());
  }
}
