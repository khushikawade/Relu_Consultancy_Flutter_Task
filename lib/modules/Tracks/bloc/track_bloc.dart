import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:relu_consultancy_task/modules/Tracks/bloc/track_event.dart';
import 'package:relu_consultancy_task/modules/Tracks/bloc/track_state.dart';
import 'package:relu_consultancy_task/modules/Tracks/respose_model/home_respose_model.dart';
import '../../../services/api.dart';

class TracksScreenBloc extends Bloc<HomeScreenEvent, TracksScreenState> {
  final ApiService apiService;
  final BuildContext context;

  TracksScreenBloc(this.apiService, this.context) : super(DataInitial()) {
    on<FetchTrackScreenData>((event, emit) async {
      emit(DataLoading());
      try {
        final homeScreenResponse = await apiService
            .getHomeScreenData(); // Adjust this to your API call
        emit(DataLoaded(homeScreenResponse.trackList as List<TrackList>));
        homeScreenResponse.trackList!.asMap().forEach((index, element) async {
          final lyricsResponse = await apiService
              .fetchLyrics(element.track!.trackId); // FetchLyrics
          homeScreenResponse.trackList![index].track!.lyrics =
              lyricsResponse.lyrics!.lyricsBody;
        });
      } catch (_) {
        emit(DataError());
      }
    });
  }
}
