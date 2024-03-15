import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:relu_consultancy_task/modules/Tracks_Details/response_model/details_response.dart';
import 'package:relu_consultancy_task/modules/Tracks/respose_model/home_respose_model.dart';
import 'package:relu_consultancy_task/modules/Tracks/respose_model/lyrics_response_model.dart';
import 'package:relu_consultancy_task/services/api_client.dart';
import 'package:relu_consultancy_task/services/api_methods.dart';
import 'package:relu_consultancy_task/services/app_utils.dart';
import 'package:relu_consultancy_task/services/constant.dart';

class ApiService {
  // //Call Api for User Login

  final ApiClient _apiClient = ApiClient();
  final ApiMethods _apiMethods = ApiMethods();

  Future<TracksScreenResponse> getHomeScreenData() async {
    bool internet = await AppUtil.checkNetwork();
    if (!internet) {
      return TracksScreenResponse(error: Constants.noInternet, statusCode: 501);
    }
    Response response = await _apiClient.getMethod(
      _apiMethods.homeScreen,
    );
    if (response.statusCode == 200) {
      try {
        if (response.body.contains('error')) {
          var jsonResponse = json.decode(response.body);
          return TracksScreenResponse(
              error: jsonResponse['error']['message'], statusCode: 500);
        } else {
          TracksScreenResponse resp = TracksScreenResponse.fromJson(
              jsonDecode(response.body.toString()));
          resp.statusCode = response.statusCode;
          // return resp;
          return TracksScreenResponse(
              trackList: resp.message!.body!.trackList, statusCode: 200);
        }
      } catch (e) {
        return TracksScreenResponse(
            error: Constants.somethingWentWorng, statusCode: 500);
      }
    } else {
      return TracksScreenResponse(
          error: Constants.somethingWentWorng, statusCode: response.statusCode);
    }
  }

  Future<TrackDetailsScreenResponse> getDetailsScreenData(trackID) async {
    bool internet = await AppUtil.checkNetwork();
    if (!internet) {
      return TrackDetailsScreenResponse(
          error: Constants.noInternet, statusCode: 501);
    }
    // Response response = await _apiClient.getMethod(
    //   // "?search=$key"
    //   _apiMethods.detailsScreen +
    //       "$trackID&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7",
    // );
    Response response = await _apiClient.getMethod(
        "https://api.musixmatch.com/ws/1.1/track.get?track_id=$trackID&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7");
    // .getMethod("${_apiMethods.detailsScreen}$trackID${_apiMethods.apiKey}");
    if (response.statusCode == 200) {
      try {
        if (response.body.contains('error')) {
          var jsonResponse = json.decode(response.body);
          return TrackDetailsScreenResponse(
              error: jsonResponse['error']['message'], statusCode: 500);
        } else {
          TrackDetailsScreenResponse resp = TrackDetailsScreenResponse.fromJson(
              jsonDecode(response.body.toString()));
          resp.statusCode = response.statusCode;
          // return resp;

          return TrackDetailsScreenResponse(
              track: resp.message!.body!.track, statusCode: 200);
        }
      } catch (e) {
        return TrackDetailsScreenResponse(
            error: Constants.somethingWentWorng, statusCode: 500);
      }
    } else {
      return TrackDetailsScreenResponse(
          error: Constants.somethingWentWorng, statusCode: response.statusCode);
    }
  }

  Future<LyricsResponse> fetchLyrics(trackID) async {
    bool internet = await AppUtil.checkNetwork();
    if (!internet) {
      return LyricsResponse(error: Constants.noInternet, statusCode: 501);
    }
    // Response response = await _apiClient.getMethod(
    //   // "?search=$key"
    //   _apiMethods.detailsScreen +
    //       "$trackID&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7",
    // );
    Response response = await _apiClient.getMethod(
        "https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=$trackID&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7");
    // .getMethod("${_apiMethods.detailsScreen}$trackID${_apiMethods.apiKey}");
    if (response.statusCode == 200) {
      try {
        if (response.body.contains('error')) {
          var jsonResponse = json.decode(response.body);
          return LyricsResponse(
              error: jsonResponse['error']['message'], statusCode: 500);
        } else {
          LyricsResponse resp =
              LyricsResponse.fromJson(jsonDecode(response.body.toString()));
          resp.statusCode = response.statusCode;
          // return resp;
          return LyricsResponse(
              lyrics: resp.message!.body!.lyrics, statusCode: 200);
        }
      } catch (e) {
        return LyricsResponse(
            error: Constants.somethingWentWorng, statusCode: 500);
      }
    } else {
      return LyricsResponse(
          error: Constants.somethingWentWorng, statusCode: response.statusCode);
    }
  }
}
