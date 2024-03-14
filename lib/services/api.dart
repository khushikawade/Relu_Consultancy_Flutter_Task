import 'dart:convert';

import 'package:http/http.dart';
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
              trackList: resp.message!.body!.trackList, statusCode: 500);
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
}
