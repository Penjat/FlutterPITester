// import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
// import '../models/item_model.dart';

class PITesterBloc {
  final _intents = PublishSubject<PITesterIntent>();

  Observable<PITesterViewState> get viewState => _intents.map((intent) => PITesterViewState("hello"));
  void processInput(PITesterIntent intent){
    _intents.sink.add(intent);
  }

  String getString() {
    return "this is from the view model";
  }
}

abstract class PITesterIntent{}
class PressedKey extends PITesterIntent {
  int keyNumber;
}

class PITesterViewState{
  PITesterViewState(this.displayNumber);
  String displayNumber;
}
