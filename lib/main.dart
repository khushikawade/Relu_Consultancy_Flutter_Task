import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:relu_consultancy_task/modules/home/bloc/home_bloc.dart';
import 'package:relu_consultancy_task/modules/home/ui/home_screen.dart';

import 'services/api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<HomeScreenBloc>(
        create: (context) => HomeScreenBloc(
            ApiService(), context), // Provide your DataBloc instance
        child: const HomeScreen(),
      ),
    );
  }
}
