import 'dart:io';
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

  /// Input
  void processInput(PITesterIntent intent){
    _intents.sink.add(intent);
  }

  /// Internal (side effects)
  PITesterResult intentToResult(PITesterIntent intent) {
    if(intent is PressedKey) {
      PressedKey pressedKeyIntnet = intent as PressedKey;
      digitsTyped = digitsTyped + pressedKeyIntnet.keyNumber.toString();
      if(pressedKeyIntnet.keyNumber == 4) {
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
