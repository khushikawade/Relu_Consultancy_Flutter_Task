import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:relu_consultancy_task/modules/Details/bloc/details_event.dart';
import 'package:relu_consultancy_task/modules/Details/bloc/details_state.dart';

import '../../../services/api.dart';

class DetailsScreenBloc extends Bloc<DetailsScreenEvent, DetailsScreenState> {
  final ApiService apiService;

  // DetailsScreenBloc(this.apiService) : super(DataInitial());/

  DetailsScreenBloc(this.apiService) : super(DataInitial()) {
    on<FetchDetailsScreenData>((event, emit) async {
      emit(DataLoading());
      try {
        final detailsScreenResponse = await apiService
            .getDetailsScreenData(event.id); // Adjust this to your API call

        // emit(DataLoaded(detailsScreenResponse.trackList as List<TrackList>));
        print("data---------------${detailsScreenResponse.track!.albumName}");
      } catch (_) {
        emit(DataError());
      }
    });
  }
}
