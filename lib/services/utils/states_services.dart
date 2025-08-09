import 'dart:convert';

import 'package:covid_19_api_application/model/world_state_model.dart';
import 'package:covid_19_api_application/services/utils/app_url.dart';
import 'package:http/http.dart' as http;

class StatesServices {
  Future<WorldStatsModel> fetchWorldData() async {
    final response = await http.get(Uri.parse(AppUrls.worldStateApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatsModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> countriesStates() async {
    // ignore: prefer_typing_uninitialized_variables
    var data;
    final response = await http.get(Uri.parse(AppUrls.countriesList));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
