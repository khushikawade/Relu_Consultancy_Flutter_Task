import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:relu_consultancy_task/modules/Details/bloc/details_bloc.dart';
import 'package:relu_consultancy_task/modules/home/bloc/home_bloc.dart';

import 'package:relu_consultancy_task/modules/home/bloc/home_event.dart';
import 'package:relu_consultancy_task/modules/home/bloc/home_state.dart';

import '../../../services/api.dart';
import '../../Details/ui/details_view.dart';
import '../respose_model/home_respose_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final homeScreenBloc = BlocProvider.of<HomeScreenBloc>(context);
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

              return BlocProvider(
                create: (context) => HomeScreenBloc(ApiService(), context),
                child: BlocListener<HomeScreenBloc, HomeScreenState>(
                  listener: (context, state) {
                    // Handle state changes if needed
                  },
                  child: isConnected
                      ? YourConnectedUI() // Your UI when device is online
                      : YourOfflineUI(), // Your UI when device is offline
                ),
              );
            },
            child: Container(), // Empty child as it will be replaced
          ),
        ));
  }
}

class YourConnectedUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Build your UI based on HomeBloc state

    // return Padding(
    //   padding: const EdgeInsets.only(top: 16, bottom: 16),
    //   child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
    //     builder: (context, state) {
    //       if (state is DataLoading) {
    //         return const Center(child: CircularProgressIndicator());
    //       } else if (state is DataLoaded) {
    //         return ListView.builder(
    //           itemCount: state.trackList.length,
    //           itemBuilder: (context, index) {
    //             return Padding(
    //               padding: const EdgeInsets.only(left: 16, right: 16),
    //               child: Container(
    //                 padding: const EdgeInsets.only(
    //                     left: 6, right: 6, top: 6, bottom: 6),
    //                 margin: const EdgeInsets.only(bottom: 16),
    //                 decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(10),
    //                   color: Colors.white,
    //                 ),
    //                 child: InkWell(
    //                   onTap: () {
    //                     Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                         builder: (context) =>
    //                             BlocProvider<DetailsScreenBloc>(
    //                           create: (context) =>
    //                               DetailsScreenBloc(ApiService()),
    //                           child: DetailsScreen(
    //                               id: state.trackList[index].track!.trackId
    //                                   .toString()),
    //                         ),
    //                       ),
    //                     );
    //                   },
    //                   child: ListTile(
    //                     leading: Icon(Icons.music_note),
    //                     title: Text(
    //                         maxLines: 2,
    //                         overflow: TextOverflow.ellipsis,
    //                         state.trackList[index].track!.albumName.toString()),
    //                     subtitle: Text(
    //                         maxLines: 2,
    //                         overflow: TextOverflow.clip,
    //                         state.trackList[index].track!.trackName.toString()),
    //                     trailing: Text(
    //                       state.trackList[index].track!.artistName.toString(),
    //                     ),
    //                     // Add more UI components here
    //                   ),
    //                 ),
    //               ),
    //             );
    //           },
    //         );
    //       } else if (state is DataError) {
    //         return Text('Error fetching data');
    //       }
    //       return Container();
    //     },
    //   ),
    // );

    return Center(
      child: Text('You are online'),
    );
  }
}

class YourOfflineUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('You are offline. Please check your internet connection.'),
    );
  }
}
