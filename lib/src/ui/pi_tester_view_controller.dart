import 'package:flutter/material.dart';
import 'package:reactive_pi_tester/src/styles.dart';
import 'package:reactive_pi_tester/src/blocs/pi_tester_bloc.dart';
import 'package:reactive_pi_tester/src/ui/digit_keypad.dart';
import 'package:flutter/animation.dart';

class _Constants {
  static double flashDigitSize = 200;
  static Duration countDigitDuration = const Duration(milliseconds: 400);
}

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
        backgroundColor: PiStyles.appBarColor,
        title: Text(
          "pi Tester",
          style: PiStyles.mainTitle,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            child: DigitCounter(viewState.currentDigit),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 32.0, 0.0),
            child: ElevatedButton(
              onPressed: reset,
              child: Text("Reset"),
              style: PiStyles.buttonStyle,
            ),
          ),
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
                    style: PiStyles.correctDigitsStyle,
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
                      child: Text(
                        digit,
                        style: TextStyle(
                            fontSize: value * _Constants.flashDigitSize,
                            color: PiStyles.flashDigitColor),
                      )));
            });
  }

  pressedKey(int keyNumber) {
    piTesterBloc.processInput(PressedKey(keyNumber));
  }

  reset() {
    piTesterBloc.processInput(ResetIntent());
  }
}

class DigitCounter extends StatelessWidget {
  DigitCounter(this.currentDigit);

  String currentDigit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Current Digit",
          style: PiStyles.staticTitle,
        ),
        AnimatedSwitcher(
          child: Text(currentDigit,
              style: PiStyles.dynamicField,
              key: ValueKey<String>(currentDigit)),
          duration: _Constants.countDigitDuration,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(child: child, scale: animation);
          },
        ),
      ],
    );
  }
}

class _ResetButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

