import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:tva_vaje/screens/arrival_event_form_screen.dart';

import 'db/arrival_events_provider.dart';
import 'models/arrival_event.dart';


void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ArrivalEventAdapter());
  await Hive.openBox<ArrivalEvent>('arrival_events');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ArrivalEventsProvider()),
      ],
      child: MaterialApp(
        title: 'TVA App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          useMaterial3: true,
        ),
        home: const ArrivalEventFormScreen(),
      ),
    );
  }
}