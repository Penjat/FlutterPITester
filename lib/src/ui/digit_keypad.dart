import 'package:flutter/material.dart';
import 'package:reactive_pi_tester/src/Styles.dart';

class DigitKeypad extends StatelessWidget {
  DigitKeypad(this.pressedKey);

  Function pressedKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      color: PiStyles.appBarColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            KeypadKey(0, pressedKey),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                KeypadKey(1, pressedKey),
                KeypadKey(2, pressedKey),
                KeypadKey(3, pressedKey),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                KeypadKey(4, pressedKey),
                KeypadKey(5, pressedKey),
                KeypadKey(6, pressedKey),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                KeypadKey(7, pressedKey),
                KeypadKey(8, pressedKey),
                KeypadKey(9, pressedKey),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget KeypadKey(int number, Function pressedFunction) {
    return FloatingActionButton.extended(
      onPressed: () {
        pressedFunction(number);
      },
      label: Text(number.toString(), style: PiStyles.keyPadTextStyle),
      backgroundColor: PiStyles.keyColor,
    );
  }
}
