import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:relu_consultancy_task/modules/Details/response_model/details_response.dart';
import 'package:relu_consultancy_task/modules/home/respose_model/home_respose_model.dart';
import 'package:relu_consultancy_task/services/api_client.dart';
import 'package:relu_consultancy_task/services/api_methods.dart';
import 'package:relu_consultancy_task/services/app_utils.dart';
import 'package:relu_consultancy_task/services/constant.dart';

class ApiService {
  // //Call Api for User Login

  final ApiClient _apiClient = ApiClient();
  final ApiMethods _apiMethods = ApiMethods();

  Future<HomeScreenResponse> getHomeScreenData() async {
    bool internet = await AppUtil.checkNetwork();
    if (!internet) {
      return HomeScreenResponse(error: Constants.noInternet, statusCode: 501);
    }
    Response response = await _apiClient.getMethod(
      _apiMethods.homeScreen,
    );
    if (response.statusCode == 200) {
      try {
        if (response.body.contains('error')) {
          var jsonResponse = json.decode(response.body);
          return HomeScreenResponse(
              error: jsonResponse['error']['message'], statusCode: 500);
        } else {
          HomeScreenResponse resp =
              HomeScreenResponse.fromJson(jsonDecode(response.body.toString()));
          resp.statusCode = response.statusCode;
          // return resp;
          return HomeScreenResponse(
              trackList: resp.message!.body!.trackList, statusCode: 200);
        }
      } catch (e) {
        return HomeScreenResponse(
            error: Constants.somethingWentWorng, statusCode: 500);
      }
    } else {
      return HomeScreenResponse(
          error: Constants.somethingWentWorng, statusCode: response.statusCode);
    }
  }

  Future<DetailsScreenResponse> getDetailsScreenData(trackID) async {
    bool internet = await AppUtil.checkNetwork();
    if (!internet) {
      return DetailsScreenResponse(
          error: Constants.noInternet, statusCode: 501);
    }
    // Response response = await _apiClient.getMethod(
    //   // "?search=$key"
    //   _apiMethods.detailsScreen +
    //       "$trackID&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7",
    // );
    Response response = await _apiClient.getMethod(
        "https://api.musixmatch.com/ws/1.1/track.get?track_id=255355136&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7");
    // .getMethod("${_apiMethods.detailsScreen}$trackID${_apiMethods.apiKey}");
    if (response.statusCode == 200) {
      try {
        if (response.body.contains('error')) {
          var jsonResponse = json.decode(response.body);
          return DetailsScreenResponse(
              error: jsonResponse['error']['message'], statusCode: 500);
        } else {
          DetailsScreenResponse resp = DetailsScreenResponse.fromJson(
              jsonDecode(response.body.toString()));
          resp.statusCode = response.statusCode;
          // return resp;
          return DetailsScreenResponse(
              track: resp.message!.body!.track, statusCode: 200);
        }
      } catch (e) {
        return DetailsScreenResponse(
            error: Constants.somethingWentWorng, statusCode: 500);
      }
    } else {
      return DetailsScreenResponse(
          error: Constants.somethingWentWorng, statusCode: response.statusCode);
    }
  }
}
