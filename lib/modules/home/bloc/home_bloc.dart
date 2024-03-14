import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:relu_consultancy_task/modules/home/bloc/home_event.dart';
import 'package:relu_consultancy_task/modules/home/bloc/home_state.dart';
import 'package:relu_consultancy_task/modules/home/respose_model/home_respose_model.dart';

import '../../../services/api.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final ApiService apiService;

  // HomeScreenBloc(this.apiService) : super(DataInitial());/

  HomeScreenBloc(this.apiService) : super(DataInitial()) {
    on<FetchHomeScreenData>((event, emit) async {
      emit(DataLoading());
      try {
        final homeScreenResponse = await apiService
            .getHomeScreenData(); // Adjust this to your API call

        emit(DataLoaded(homeScreenResponse.trackList as List<TrackList>));
        print("data---------------${homeScreenResponse.trackList!.length}");
      } catch (_) {
        emit(DataError());
      }
    });
  }
}
