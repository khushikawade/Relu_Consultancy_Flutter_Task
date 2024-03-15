import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:relu_consultancy_task/modules/Tracks_Details/bloc/details_bloc.dart';
import 'package:relu_consultancy_task/modules/Tracks_Details/bloc/details_event.dart';
import 'package:relu_consultancy_task/modules/Tracks_Details/bloc/details_state.dart';

import '../../../services/helper/network_error widget.dart';

class TrackDetailsScreen extends StatefulWidget {
  String? trackId;
  TrackDetailsScreen({super.key, this.trackId});

  @override
  State<TrackDetailsScreen> createState() => _TrackDetailsScreenState();
}

class _TrackDetailsScreenState extends State<TrackDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color(0xffEFF1F2),
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(40), // Adjust the radius as needed
              ),
            ),
            backgroundColor: Colors.deepPurple,
            centerTitle: true,
            title: const Text(
              'Tracks Details',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          body: OfflineBuilder(
            connectivityBuilder: (
              BuildContext context,
              ConnectivityResult connectivity,
              Widget child,
            ) {
              final isConnected = connectivity != ConnectivityResult.none;
              return isConnected
                  ? bodyWidget(
                      context, widget.trackId!) // Your UI when device is online
                  : networkWidget();
            },
            child: Container(), // Empty child as it will be replaced
          ),
        ));
  }
}

bodyWidget(context, id) {
  final detailsScreenBloc = BlocProvider.of<TrackDetailsScreenBloc>(context);
  detailsScreenBloc.add(FetchDetailsScreenData(id));
  return Padding(
    padding: const EdgeInsets.only(top: 16, bottom: 16),
    child: BlocBuilder<TrackDetailsScreenBloc, TrackDetailsScreenState>(
      builder: (context, state) {
        if (state is DataLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DataLoaded) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(children: [
              const Text(
                "Track Name",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                  "${state.data.trackName != null && state.data.trackName!.isNotEmpty ? state.data.trackName : "NA"}"),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Album Name",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                  "${state.data.albumName != null && state.data.albumName!.isNotEmpty ? state.data.albumName : "NA"}"),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Artist Name",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                  "${state.data.artistName != null && state.data.artistName!.isNotEmpty ? state.data.artistName : "NA"}"),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Update Time",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text("${state.data.updatedTime ?? "NA"}"),
            ]),
          );
        } else if (state is DataError) {
          return const Text('Error fetching data');
        }
        return Container();
      },
    ),
  );
}

networkWidget() {
  return Center(
    child: NetworkError(
      content: 'Tracks Details not found.',
      subContant: "No data, Please try again later.",
      icon: 'assets/icon/mobile_network_error.png',
    ),
  );
}
