import 'dart:io';
import 'package:rxdart/rxdart.dart';


class PITesterBloc {
  final _intents = PublishSubject<PITesterIntent>();
  int numberOfPresses = 0;
  Observable<PITesterResult> get _results => _intents.map(intentToResult);
  Observable<PITesterViewState> get viewState => _results.map(resultToState);

  void processInput(PITesterIntent intent){
    _intents.sink.add(intent);
  }

  PITesterViewState resultToState(PITesterResult result) {
    if(result is CorrectResult){
      return PITesterViewState("that is correct");
    }
    return PITesterViewState("hello this is from a function " + numberOfPresses.toString());
  }

  PITesterResult intentToResult(PITesterIntent intent) {
    if(intent is PressedKey) {
      PressedKey pressedKeyIntnet = intent as PressedKey;
      if(pressedKeyIntnet.keyNumber == 4) {
        return CorrectResult();
      }
    }
    return IncorrectResult();
  }
}

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
