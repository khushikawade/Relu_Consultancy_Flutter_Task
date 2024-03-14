import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:relu_consultancy_task/modules/home/bloc/home_event.dart';
import 'package:relu_consultancy_task/modules/home/bloc/home_state.dart';
import 'package:relu_consultancy_task/modules/home/respose_model/home_respose_model.dart';

import '../../../services/api.dart';
import '../../../services/app_utils.dart';
import '../../../services/constant.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final ApiService apiService;

  // HomeScreenBloc(this.apiService) : super(DataInitial());/

  HomeScreenBloc(this.apiService) : super(DataInitial()) {
    on<FetchHomeScreenData>((event, emit) async {
      emit(DataLoading());
      try {
        final homeScreenResponse = await apiService
            .getHomeScreenData(); // Adjust this to your API call

        // Check the status code
        switch (homeScreenResponse.statusCode) {
          case Constants.sucessCode:
            // Success case (status code 200)
            print("Data received: ${homeScreenResponse.trackList!.length}");
            emit(DataLoaded(homeScreenResponse.trackList as List<TrackList>));
            // Emit success state or update UI accordingly
            break;
          case Constants.wrongError:
            // AppUtil.showDialogbox(AppUtil.getContext(),
            //     homeScreenResponse.error ?? 'Oops Something went wrong');
            break;
          default:
            // Handle other status codes if needed
            break;
        }
      } catch (_) {
        emit(DataError());
      }
    });
  }
}
