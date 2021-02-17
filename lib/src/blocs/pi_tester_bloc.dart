// import '../resources/repository.dart';
// import 'package:rxdart/rxdart.dart';
// import '../models/item_model.dart';

class PITesterBloc {
  processInput(int number){
    print(number.toString() + " was pressed");
    //TODO: add to a publish subject
  }
  String getString() {
    return "this is from the view model";
  }
}