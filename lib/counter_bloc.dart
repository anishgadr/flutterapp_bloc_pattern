import 'dart:async';

enum CounterAction {
  Increment,
  Decrement,
  Reset,
}

class CounterBloc {
  int counter;
  final _stateSteamController = StreamController<int>();
  StreamSink<int> get counterSink => _stateSteamController.sink; //input
  Stream<int> get counterSteam => _stateSteamController.stream; //output

  final _eventSteamController = StreamController<CounterAction>();
  StreamSink<CounterAction> get eventSink => _eventSteamController.sink; //input
  Stream<CounterAction> get eventSteam => _eventSteamController.stream; //output

  CounterBloc() {
    counter = 0;
    eventSteam.listen((event) {
      if (event == CounterAction.Increment) {
        counter++;
      } else if (event == CounterAction.Decrement) {
        counter > 0 ? counter = 0 : counter--;
      } else if (event == CounterAction.Reset) {
        counter = 0;
      }
      counterSink.add(counter);
    });
  }
}
