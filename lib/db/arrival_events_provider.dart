import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../models/arrival_event.dart';

class ArrivalEventsProvider with ChangeNotifier {
  final _arrivalEventsBox = Hive.box<ArrivalEvent>('arrival_events');

  List<ArrivalEvent> get arrivalEvents => _arrivalEventsBox.values.toList();

  void addArrivalEvent(ArrivalEvent arrivalEvent) {
    _arrivalEventsBox.add(arrivalEvent);
    notifyListeners();
  }

  void putArrivalEvent(int key, ArrivalEvent arrivalEvent) {
    _arrivalEventsBox.put(key, arrivalEvent);
    notifyListeners();
  }

  void deleteArrivalEvent(int key) {
    _arrivalEventsBox.delete(key);
    notifyListeners();
  }

  ArrivalEvent? getArrivalEvent(int key) {
    return _arrivalEventsBox.get(key);
  }
}