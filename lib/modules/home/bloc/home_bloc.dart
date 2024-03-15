import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:relu_consultancy_task/modules/home/bloc/home_event.dart';
import 'package:relu_consultancy_task/modules/home/bloc/home_state.dart';
import 'package:relu_consultancy_task/modules/home/respose_model/home_respose_model.dart';

import '../../../services/api.dart';
import '../../../services/app_utils.dart';
import '../../../services/constant.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final ApiService apiService;
  final BuildContext context;

  // HomeScreenBloc(this.apiService) : super(DataInitial());/

  HomeScreenBloc(this.apiService, this.context) : super(DataInitial()) {
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
            // ignore: use_build_context_synchronously
            AppUtil.showDialogbox(context,
                homeScreenResponse.error ?? 'Oops Something went wrong');
            break;
          case Constants.networkErroCode:
            // ignore: use_build_context_synchronously
            AppUtil.showDialogbox(context,
                homeScreenResponse.error ?? 'Oops Something went wrong');

            break;
          default:
            {
              if (homeScreenResponse.error != null &&
                  homeScreenResponse.error!.isNotEmpty) {
                AppUtil.showDialogbox(context,
                    homeScreenResponse.error ?? 'Oops Something went wrong');
              }
            }
            break;
        }
      } catch (_) {
        emit(DataError());
      }
    });
  }
}
