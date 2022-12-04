//Provider

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sampleProvider = Provider((ref) => CounterProvider());

class CounterProvider {
  int number = 0;

  void increment(){
    number++;
  }

  void decrement(){
    number--;
  }

}

// change notifier provider

final changeProvider = ChangeNotifierProvider((ref) => CounterProvider1());
class CounterProvider1 extends ChangeNotifier {
  int number = 0;

  void increment(){
    number++;
    notifyListeners();
  }

  void decrement(){
    number--;
    notifyListeners();
  }

}

//state Provider

final stateProvider = StateProvider<int>((ref) => 0);


