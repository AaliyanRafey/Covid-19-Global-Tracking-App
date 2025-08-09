class WorldStatsModel {
  final int updated;
  final int cases;
  final int todayCases;
  final int deaths;
  final int todayDeaths;
  final int recovered;
  final int todayRecovered;
  final int active;
  final int critical;
  final int casesPerOneMillion;
  final double deathsPerOneMillion;
  final int tests;
  final double testsPerOneMillion;
  final int population;
  final int oneCasePerPeople;
  final int oneDeathPerPeople;
  final int oneTestPerPeople;
  final double activePerOneMillion;
  final double recoveredPerOneMillion;
  final double criticalPerOneMillion;
  final int affectedCountries;

  WorldStatsModel({
    required this.updated,
    required this.cases,
    required this.todayCases,
    required this.deaths,
    required this.todayDeaths,
    required this.recovered,
    required this.todayRecovered,
    required this.active,
    required this.critical,
    required this.casesPerOneMillion,
    required this.deathsPerOneMillion,
    required this.tests,
    required this.testsPerOneMillion,
    required this.population,
    required this.oneCasePerPeople,
    required this.oneDeathPerPeople,
    required this.oneTestPerPeople,
    required this.activePerOneMillion,
    required this.recoveredPerOneMillion,
    required this.criticalPerOneMillion,
    required this.affectedCountries,
  });

  factory WorldStatsModel.fromJson(Map<String, dynamic> json) {
    return WorldStatsModel(
      updated: json['updated'],
      cases: json['cases'],
      todayCases: json['todayCases'],
      deaths: json['deaths'],
      todayDeaths: json['todayDeaths'],
      recovered: json['recovered'],
      todayRecovered: json['todayRecovered'],
      active: json['active'],
      critical: json['critical'],
      casesPerOneMillion: json['casesPerOneMillion'],
      deathsPerOneMillion: json['deathsPerOneMillion'].toDouble(),
      tests: json['tests'],
      testsPerOneMillion: json['testsPerOneMillion'].toDouble(),
      population: json['population'],
      oneCasePerPeople: json['oneCasePerPeople'],
      oneDeathPerPeople: json['oneDeathPerPeople'],
      oneTestPerPeople: json['oneTestPerPeople'],
      activePerOneMillion: json['activePerOneMillion'].toDouble(),
      recoveredPerOneMillion: json['recoveredPerOneMillion'].toDouble(),
      criticalPerOneMillion: json['criticalPerOneMillion'].toDouble(),
      affectedCountries: json['affectedCountries'],
    );
  }
}
