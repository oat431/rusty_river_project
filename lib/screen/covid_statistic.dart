import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rusty_river_project/component/rr_bottom_app_bar.dart';
import 'package:rusty_river_project/model/covid_country.dart';
import 'package:rusty_river_project/model/covid_global.dart';
import 'package:rusty_river_project/service/covid_api.dart';

class CovidStatistic extends StatefulWidget {
  const CovidStatistic({Key? key}) : super(key: key);

  @override
  _CovidStatisticState createState() => _CovidStatisticState();
}

class _CovidStatisticState extends State<CovidStatistic> {
  late final CovidApi covidApi = CovidApi();
  late CovidGlobal covidGlobal;
  late List<CovidCountry> covidCountry = [];

  Future<List<CovidCountry>> getAllCovidStatus() async {
    var response = await covidApi.getCovidSummary();
    List res = json.decode(response.body)["Countries"];
    covidCountry = res.map((status) => CovidCountry.fromJson(status)).toList();
    covidGlobal = CovidGlobal.fromJson(json.decode(response.body));
    return covidCountry;
  }

  @override
  void initState() {
    super.initState();
    getAllCovidStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Covid Status"),
      ),
      body: Container(),
      bottomNavigationBar: const RustyRiverBottomBar(),
    );
  }
}
