import 'package:flutter/material.dart';
import 'package:reactive_pi_tester/src/blocs/pi_tester_bloc.dart';

class PITesterViewController extends StatelessWidget {
  PITesterViewController(this.piTesterBloc);
  PITesterBloc piTesterBloc;
  @override
  Widget build(BuildContext context) {
    // bloc.fetchAllMovies();
    return ElevatedButton(onPressed: keyPressed,
    child: Text("button text"));
  }
  void keyPressed() {
    piTesterBloc.processInput(PressedKey());
  }
}
