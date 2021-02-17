import 'package:flutter/material.dart';
import 'package:reactive_pi_tester/src/blocs/pi_tester_bloc.dart';

class PITesterViewController extends StatelessWidget {
  PITesterViewController(this.piTesterBloc);
  PITesterBloc piTesterBloc;
  @override
  Widget build(BuildContext context) {
    // bloc.fetchAllMovies();
    return StreamBuilder(
      stream: piTesterBloc.viewState,
      builder: (context, AsyncSnapshot<PITesterViewState> snapshot) {
        if (snapshot.hasData) {
          return ElevatedButton(onPressed: keyPressed, child: Text(snapshot.data.displayNumber));
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return ElevatedButton(onPressed: keyPressed, child: Text("no data yet"));
      },
    );
  }
  void keyPressed() {
    piTesterBloc.processInput(PressedKey());
  }
}
