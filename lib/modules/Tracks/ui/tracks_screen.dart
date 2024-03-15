import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:relu_consultancy_task/modules/Tracks_Details/bloc/details_bloc.dart';
import 'package:relu_consultancy_task/modules/Tracks/bloc/home_bloc.dart';

import 'package:relu_consultancy_task/modules/Tracks/bloc/home_event.dart';
import 'package:relu_consultancy_task/modules/Tracks/bloc/home_state.dart';

import '../../../services/api.dart';
import '../../../services/helper/network_error widget.dart';
import '../../../services/helper/shimmer_loading.dart';
import '../../Tracks_Details/ui/tracks_details_view.dart';

class TracksScreen extends StatefulWidget {
  const TracksScreen({super.key});
  @override
  State<TracksScreen> createState() => _TracksScreenState();
}

class _TracksScreenState extends State<TracksScreen> {
  @override
  Widget build(BuildContext context) {
    final homeScreenBloc = BlocProvider.of<TracksScreenBloc>(context);
    homeScreenBloc.add(FetchHomeScreenData());
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
              'Tracks',
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
                  ? bodyWidget(context) // Your UI when device is online
                  : networkWidget();
            },
            child: Container(), // Empty child as it will be replaced
          ),
        ));
  }
}

bodyWidget(context) {
  return Padding(
    padding: const EdgeInsets.only(top: 16, bottom: 16),
    child: BlocBuilder<TracksScreenBloc, TracksScreenState>(
      builder: (context, state) {
        if (state is DataLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DataLoaded) {
          return ListView.builder(
            itemCount: state.trackList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 6, right: 6, top: 6, bottom: 6),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BlocProvider<TrackDetailsScreenBloc>(
                            create: (context) =>
                                TrackDetailsScreenBloc(ApiService()),
                            child: TrackDetailsScreen(
                                trackId: state.trackList[index].track!.trackId
                                    .toString()),
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Icon(Icons.music_note),
                      title: Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          state.trackList[index].track!.albumName != null &&
                                  state.trackList[index].track!.albumName!
                                      .isNotEmpty
                              ? state.trackList[index].track!.albumName
                                  .toString()
                              : "NA"),
                      subtitle: state.trackList[index].track!.lyrics != null
                          ? Text(
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                              state.trackList[index].track!.lyrics.toString())
                          : ShimmerLoading(
                              isLoading: true,
                              child: Container(
                                width: double.infinity,
                                height: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[100],
                                ),
                              )),
                      trailing: Text(
                        state.trackList[index].track!.artistName != null &&
                                state.trackList[index].track!.artistName!
                                    .isNotEmpty
                            ? state.trackList[index].track!.artistName
                                .toString()
                            : "NA",
                      ),
                      // Add more UI components here
                    ),
                  ),
                ),
              );
            },
          );
        } else if (state is DataError) {
          return Center(child: Text('Error fetching data'));
        }
        return Container();
      },
    ),
  );
}

networkWidget() {
  return Center(
    child: NetworkError(
      content: 'Tracks not found.',
      subContant: "No data, Please try again later.",
      icon: 'assets/icon/mobile_network_error.png',
    ),
  );
}
