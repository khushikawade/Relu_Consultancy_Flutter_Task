import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:relu_consultancy_task/modules/Tracks_Details/bloc/details_event.dart';
import 'package:relu_consultancy_task/modules/Tracks_Details/bloc/details_state.dart';
import 'package:relu_consultancy_task/modules/Tracks_Details/response_model/details_response.dart';

import '../../../services/api.dart';

class TrackDetailsScreenBloc
    extends Bloc<DetailsScreenEvent, TrackDetailsScreenState> {
  final ApiService apiService;
  TrackDetailsScreenBloc(this.apiService) : super(DataInitial()) {
    on<FetchDetailsScreenData>((event, emit) async {
      emit(DataLoading());
      try {
        final detailsScreenResponse = await apiService
            .getDetailsScreenData(event.id); // Adjust this to your API call
        emit(DataLoaded(detailsScreenResponse.track as Track));
      } catch (_) {
        emit(DataError());
      }
    });
  }
}
