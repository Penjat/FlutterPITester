import 'package:flutter/material.dart';
import 'package:reactive_pi_tester/src/models/pi_test.dart';
import 'package:reactive_pi_tester/src/ui/pi_tester_view_controller.dart';
import 'blocs/pi_tester_bloc.dart';

class App extends StatelessWidget {
  final bloc = PITesterBloc(PiTest());
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: PITesterViewController(bloc),
      ),
    );
  }
}