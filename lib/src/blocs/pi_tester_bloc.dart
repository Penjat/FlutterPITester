import 'dart:io';
import 'package:reactive_pi_tester/src/models/pi_test.dart';
import 'package:rxdart/rxdart.dart';

/// I/O
abstract class PITesterIntent{}
class PressedKey extends PITesterIntent {
  PressedKey(this.keyNumber);
  int keyNumber;
}

abstract class PITesterResult{}
class CorrectResult extends PITesterResult {

}
class IncorrectResult extends PITesterResult {

}

class PITesterViewState{
  PITesterViewState(this.displayNumber);
  String displayNumber;
}

/// Bloc
class PITesterBloc {
  final _intents = PublishSubject<PITesterIntent>();
  String digitsTyped = "";
  Observable<PITesterResult> get _results => _intents.map(intentToResult);
  Observable<PITesterViewState> get viewState => _results.map(resultToState).startWith(PITesterViewState(digitsTyped));

  PiTest piTest = PiTest();
  /// Input
  void processInput(PITesterIntent intent){
    _intents.sink.add(intent);
  }

  /// Internal (side effects)
  PITesterResult intentToResult(PITesterIntent intent) {
    if(intent is PressedKey) {
      PressedKey pressedKeyIntnet = intent as PressedKey;
      piTest.checkCorrect(pressedKeyIntnet.keyNumber);
      if(piTest.checkCorrect(pressedKeyIntnet.keyNumber)) {
        piTest.addCorrect();
        digitsTyped = piTest.correctDigits();
        return CorrectResult();
      }
    }
    return IncorrectResult();
  }

  /// Output
  PITesterViewState resultToState(PITesterResult result) {
    if(result is CorrectResult){
      return PITesterViewState(digitsTyped);
    }
    return PITesterViewState(digitsTyped);
  }
}
