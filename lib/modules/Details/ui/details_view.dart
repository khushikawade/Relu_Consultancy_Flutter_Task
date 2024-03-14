import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:relu_consultancy_task/modules/Details/bloc/details_bloc.dart';
import 'package:relu_consultancy_task/modules/Details/bloc/details_event.dart';
import 'package:relu_consultancy_task/modules/Details/bloc/details_state.dart';

class DetailsScreen extends StatefulWidget {
  final String? id;
  const DetailsScreen({super.key, this.id});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final detailsScreenBloc = BlocProvider.of<DetailsScreenBloc>(context);
    detailsScreenBloc.add(FetchDetailsScreenData(widget.id!));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xffEFF1F2),
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(40), // Adjust the radius as needed
            ),
          ),
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: const Text(
            'Track Details',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: BlocBuilder<DetailsScreenBloc, DetailsScreenState>(
          builder: (context, state) {
            if (state is DataLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DataLoaded) {
              // Assuming you want to display the first data detail
              final data = state.data;
              // != null ? state.data : null;
              if (data != null) {
                return Column(
                  children: [
                    Text(
                      data.albumName.toString(),
                      style: TextStyle(color: Colors.amberAccent),
                    ), // Display the detail, replace with your desired widget
                    // Add more widgets to display other details if needed

                    Text(data.artistName.toString()),

                    Text(data.trackName.toString()),
                  ],
                );
              } else {
                return Text('No data available');
              }
            } else if (state is DataError) {
              return Text('Error fetching data');
            }
            return Container();
          },
        ),
      ),
    );
  }
}
