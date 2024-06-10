import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../db/arrival_events_provider.dart';
import '../models/arrival_event.dart';
import 'arrival_event_form_screen.dart';

class ArrivalEventListScreen extends StatefulWidget {

  const ArrivalEventListScreen({super.key});

  @override
  State<ArrivalEventListScreen> createState() => _ArrivalEventListScreenState();
}

class _ArrivalEventListScreenState extends State<ArrivalEventListScreen> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    List<ArrivalEvent> arrivalEvents = Provider.of<ArrivalEventsProvider>(context).arrivalEvents;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text('Arrival Event List'),
        leading: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ArrivalEventFormScreen()));
          },
        ),
      ),
      body: ListView.builder(
        itemCount: arrivalEvents.length,
        itemBuilder: (context, index) {
          ArrivalEvent event = arrivalEvents[index];
          return ListTile(
            title: Text('${event.name} ${event.surname}'),
            subtitle: Text('Occupation: ${event.occupation.toString().split('.').last}\n'
                           'Date of Birth: ${event.dateOfBirth}\n'
                           'Arrival Time: ${TimeOfDay.fromDateTime(event.arrivalTime).hour}:${TimeOfDay.fromDateTime(event.arrivalTime).minute}\n'
                           'Departure Time: ${TimeOfDay.fromDateTime(event.departureTime).hour}:${TimeOfDay.fromDateTime(event.departureTime).minute}'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ArrivalEventFormScreen(arrivalEventKey: event.key,)));
            },
          );
        },
      ),
    );
  }
}