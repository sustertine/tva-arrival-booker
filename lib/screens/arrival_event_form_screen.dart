import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tva_vaje/models/occupation.dart';
import 'package:tva_vaje/notifications/arrival_event_created_notification.dart';
import 'package:tva_vaje/screens/arrival_event_list_screen.dart';

import '../db/arrival_events_provider.dart';
import '../models/arrival_event.dart';

class ArrivalEventFormScreen extends StatefulWidget {
  const ArrivalEventFormScreen({super.key, this.arrivalEventKey});

  final int? arrivalEventKey;

  @override
  State<ArrivalEventFormScreen> createState() => _ArrivalEventFormScreenState();
}

class _ArrivalEventFormScreenState extends State<ArrivalEventFormScreen>
    with SingleTickerProviderStateMixin {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedArrivalTime = TimeOfDay.now();
  TimeOfDay selectedDepartureTime = TimeOfDay.now();
  Occupation? selectedOccupation = Occupation.frontend;

  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final dobController = TextEditingController();
  final arrivalTimeController = TextEditingController();
  final departureTimeController = TextEditingController();

  bool isEditing() => widget.arrivalEventKey != null;

  @override
  void initState() {
    if (isEditing()) {
      ArrivalEvent arrivalEvent = Provider.of<ArrivalEventsProvider>(context, listen: false).getArrivalEvent(widget.arrivalEventKey!)!;
      nameController.text = arrivalEvent.name;
      surnameController.text = arrivalEvent.surname;
      selectedOccupation = Occupation.values.firstWhere(
          (element) => element.toString() == arrivalEvent.occupation);
      selectedDate = arrivalEvent.dateOfBirth;
      selectedArrivalTime = TimeOfDay.fromDateTime(arrivalEvent.arrivalTime);
      selectedDepartureTime =
          TimeOfDay.fromDateTime(arrivalEvent.departureTime);
      dobController.text = '${selectedDate.toLocal()}'.split(' ')[0];
      arrivalTimeController.text =
          '${selectedArrivalTime.hour}:${selectedArrivalTime.minute} ${selectedArrivalTime.period.index == 0 ? 'AM' : 'PM'}';
      departureTimeController.text =
          '${selectedDepartureTime.hour}:${selectedDepartureTime.minute} ${selectedDepartureTime.period.index == 0 ? 'AM' : 'PM'}';
    }
    super.initState();
  }

  @override
  void dispose() {
    dobController.dispose();
    arrivalTimeController.dispose();
    departureTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: const Text('Arrival Event Form'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              children: [
                Text(
                  isEditing() ? 'Edit Arrival Event' : 'Add Arrival Event',
                  style: Theme.of(context).textTheme.headline6,
                ),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: surnameController,
                  decoration: const InputDecoration(labelText: 'Surname'),
                ),
                DropdownButton<Occupation>(
                  isExpanded: true,
                  hint: const Text('Select Occupation'),
                  value: selectedOccupation,
                  onChanged: (Occupation? newValue) {
                    setState(() {
                      selectedOccupation = newValue;
                    });
                  },
                  items: Occupation.values
                      .map<DropdownMenuItem<Occupation>>((Occupation value) {
                    return DropdownMenuItem<Occupation>(
                      value: value,
                      child: Text(value.toString().split('.').last),
                    );
                  }).toList(),
                ),
                GestureDetector(
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null && pickedDate != selectedDate) {
                      setState(() {
                        selectedDate = pickedDate;
                        dobController.text =
                            '${selectedDate.toLocal()}'.split(' ')[0];
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: TextField(
                      controller: dobController,
                      decoration: const InputDecoration(
                        labelText: 'Date of Birth',
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: selectedArrivalTime,
                    );
                    if (pickedTime != null &&
                        pickedTime != selectedArrivalTime) {
                      setState(() {
                        selectedArrivalTime = pickedTime;
                        arrivalTimeController.text =
                            selectedArrivalTime.format(context);
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: TextField(
                      controller: arrivalTimeController,
                      decoration: const InputDecoration(
                        labelText: 'Arrival Time',
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: selectedDepartureTime,
                    );
                    if (pickedTime != null &&
                        pickedTime != selectedDepartureTime) {
                      setState(() {
                        selectedDepartureTime = pickedTime;
                        departureTimeController.text =
                            selectedDepartureTime.format(context);
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: TextField(
                      controller: departureTimeController,
                      decoration: const InputDecoration(
                        labelText: 'Departure Time',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      DateTime today = DateTime.now();

                      var arrivalEvent = ArrivalEvent(
                          name: nameController.text,
                          surname: surnameController.text,
                          occupation: selectedOccupation.toString(),
                          dateOfBirth: selectedDate,
                          arrivalTime: DateTime(
                              today.year,
                              today.month,
                              today.day,
                              selectedArrivalTime.hour,
                              selectedArrivalTime.minute),
                          departureTime: DateTime(
                              today.year,
                              today.month,
                              today.day,
                              selectedDepartureTime.hour,
                              selectedDepartureTime.minute));

                      if (isEditing()) {
                        Provider.of<ArrivalEventsProvider>(context,
                                listen: false)
                            .putArrivalEvent(
                                widget.arrivalEventKey!, arrivalEvent);
                      } else {
                        Provider.of<ArrivalEventsProvider>(context,
                                listen: false)
                            .addArrivalEvent(arrivalEvent);
                      }

                      showAddArrivalEventSuccess(context, 'Success!',
                          buttonText: 'Ok', onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ArrivalEventListScreen()));
                      });
                    },
                    child: const Text('Submit'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ArrivalEventListScreen()));
                    },
                    child: const Text('View entries'),

                  ),
                ),
                (isEditing()
                    ? Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Provider.of<ArrivalEventsProvider>(context,
                                    listen: false)
                                .deleteArrivalEvent(widget.arrivalEventKey!);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ArrivalEventListScreen()));
                          },
                          child: const Text('Delete'),
                        ),
                      )
                    : Container()),
              ],
            ),
          ),
        ));
  }
}
