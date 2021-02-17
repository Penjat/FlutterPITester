import 'package:flutter/material.dart';

class DigitKeypad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      color: Colors.amber[600],
      child: Center(
        child:
        Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
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
        ]),
      ),
    );
  }
  pressedKey(int keyNumber) {
    print("pressed key " + keyNumber.toString());
  }
}

class KeypadKey extends StatelessWidget {
  KeypadKey(this.myNumber, this.pressedFunction);

  Function pressedFunction;
  int myNumber;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        pressedFunction(myNumber);
      },
      label: Text(myNumber.toString()),
      backgroundColor: Colors.pink,
    );
  }
}
