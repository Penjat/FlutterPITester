import 'dart:io';
import 'package:reactive_pi_tester/src/models/pi_test.dart';
import 'package:rxdart/rxdart.dart';

/// I/O
abstract class PITesterIntent{}
class PressedKey extends PITesterIntent {
  PressedKey(this.keyNumber);
  int keyNumber;
}
class ResetIntent extends PITesterIntent {}

abstract class PITesterResult{}
class CorrectResult extends PITesterResult {}
class IncorrectResult extends PITesterResult {}
class ResetResult extends PITesterResult {}

class PITesterViewState{
  PITesterViewState(this.displayNumber,this.currentDigit,this.flashDigit);
  String displayNumber;
  String currentDigit;
  String flashDigit;
}

/// Bloc
class PITesterBloc {
  PITesterBloc(this.piTest);

  PiTest piTest;
  
  final _intents = PublishSubject<PITesterIntent>();
  Observable<PITesterResult> get _results => _intents.flatMap(intentToResult);
  Observable<PITesterViewState> get viewState => _results.map(resultToState).startWith(PITesterViewState("", "0",null));

  /// Input
  void processInput(PITesterIntent intent){
    _intents.sink.add(intent);
  }

  /// Internal (side effects)
  Stream<PITesterResult> intentToResult(PITesterIntent intent) {
    // return intents.flatMap((intent) => Observable.just(CorrectResult()));
    if(intent is PressedKey) {
      PressedKey pressedKeyIntent = intent as PressedKey;
      piTest.checkCorrect(pressedKeyIntent.keyNumber);
      if(piTest.checkCorrect(pressedKeyIntent.keyNumber)) {
        piTest.addCorrect();
        return Observable.just(CorrectResult());
      }
      return Observable.just(IncorrectResult());
    }

    if(intent is ResetIntent){
      piTest.reset();
      return Observable.just(ResetResult());
    }
    return Observable.empty();
  }

  /// Output
  PITesterViewState resultToState(PITesterResult result) {
    if(result is CorrectResult) {
      return PITesterViewState(
          piTest.correctDigits(),
          piTest.currentDigit.toString(),
          "i"
      );
    }
    if(result is IncorrectResult){
      return PITesterViewState(piTest.correctDigits(),
          piTest.currentDigit.toString(),null);
    }
    if(result is ResetResult)
    return PITesterViewState(piTest.correctDigits(),
        piTest.currentDigit.toString(),null);
  }
}
