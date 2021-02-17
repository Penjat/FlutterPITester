// import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
// import '../models/item_model.dart';

class PITesterBloc {
  final _intents = PublishSubject<PITesterIntent>();
  processInput(PITesterIntent intent){

     if (intent is PressedKey){
       print("is a pressed key intent");
     } else {
       print("is another kind of intent");
     }

    print(" was pressed");
    //TODO: add to a publish subject
  }
  String getString() {
    return "this is from the view model";
  }
}

abstract class PITesterIntent{}
class PressedKey extends PITesterIntent {
  int keyNumber;
}