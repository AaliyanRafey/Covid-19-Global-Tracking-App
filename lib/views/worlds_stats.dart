import 'package:covid_19_api_application/model/world_state_model.dart';
import 'package:covid_19_api_application/services/utils/states_services.dart';
import 'package:covid_19_api_application/views/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldsStatsScreen extends StatefulWidget {
  const WorldsStatsScreen({super.key});

  @override
  State<WorldsStatsScreen> createState() => _WorldsStatsScreenState();
}

class _WorldsStatsScreenState extends State<WorldsStatsScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();
  @override
  void initState() {
    super.initState();

    // Timer(
    //   const Duration(seconds: 5),
    //   () => Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => WorldsStatsScreen()),
    //   ),
    // );
  }

  final colorList = <Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      // backgroundColor: Color(0xff2E2E2E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                // 👇 Add your heading here
                Text(
                  "Global COVID-19 Tracker",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                FutureBuilder(
                  future: statesServices.fetchWorldData(),
                  builder: (context, AsyncSnapshot<WorldStatsModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                        child: SpinKitFadingCircle(
                          color: Colors.black,
                          size: 50,
                          controller: _controller,
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          PieChart(
                            chartRadius:
                                MediaQuery.of(context).size.width * 0.5,
                            chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true,
                            ),
                            animationDuration: Duration(milliseconds: 1400),
                            chartType: ChartType.ring,
                            colorList: colorList,
                            dataMap: {
                              'Total': double.parse(
                                snapshot.data!.cases.toString(),
                              ),
                              'Recovered': double.parse(
                                snapshot.data!.recovered.toString(),
                              ),
                              'Deaths': double.parse(
                                snapshot.data!.deaths.toString(),
                              ),
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.03,
                            ),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  children: [
                                    ResusableRow(
                                      title: 'Total Patients',
                                      value: snapshot.data!.cases.toString(),
                                    ),
                                    ResusableRow(
                                      title: 'Recovered',
                                      value: snapshot.data!.recovered
                                          .toString(),
                                    ),
                                    ResusableRow(
                                      title: 'Death toll',
                                      value: snapshot.data!.deaths.toString(),
                                    ),
                                    ResusableRow(
                                      title: 'Affected Countries',
                                      value: snapshot.data!.affectedCountries
                                          .toString(),
                                    ),
                                    ResusableRow(
                                      title: 'Cases Per Million',
                                      value: snapshot.data!.casesPerOneMillion
                                          .toString(),
                                    ),
                                    ResusableRow(
                                      title: 'Critical Cases',
                                      value: snapshot.data!.critical.toString(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CountriesListScreen(),
                                ),
                              );
                            },
                            child: Container(
                              height: 58,
                              decoration: BoxDecoration(
                                color: Color(0xff1aa260),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Center(
                                child: Text(
                                  'Track Countries',
                                  style: TextStyle(
                                    color: Color(0xffFFFFFF),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ResusableRow extends StatelessWidget {
  final String title, value;

  const ResusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
