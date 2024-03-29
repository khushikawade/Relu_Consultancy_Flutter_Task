import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:relu_consultancy_task/modules/Tracks/bloc/track_bloc.dart';
import 'package:relu_consultancy_task/modules/Tracks/ui/tracks_screen.dart';

import 'services/api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: const Color.fromARGB(255, 221, 17, 85),
      debugShowCheckedModeBanner: false,
      home: BlocProvider<TracksScreenBloc>(
        create: (context) =>
            TracksScreenBloc(ApiService(), context), // Provide  Bloc instance
        child: const TracksScreen(),
      ),
    );
  }
}
