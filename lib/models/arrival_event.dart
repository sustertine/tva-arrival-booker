import 'package:hive/hive.dart';

part 'arrival_event.g.dart';

@HiveType(typeId: 0)
class ArrivalEvent extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String surname;
  @HiveField(2)
  final String occupation;
  @HiveField(3)
  final DateTime dateOfBirth;
  @HiveField(4)
  final DateTime arrivalTime;
  @HiveField(5)
  final DateTime departureTime;

  ArrivalEvent({
    required this.name,
    required this.surname,
    required this.occupation,
    required this.dateOfBirth,
    required this.arrivalTime,
    required this.departureTime,
  });
}