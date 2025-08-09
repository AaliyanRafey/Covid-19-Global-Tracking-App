import 'package:covid_19_api_application/services/utils/states_services.dart';
import 'package:covid_19_api_application/views/country_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),

      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search for a country',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(70),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: statesServices.countriesStates(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          child: Column(
                            children: [
                              ListTile(
                                title: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.black,
                                ),
                                subtitle: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.black,
                                ),
                                leading: Container(
                                  height: 60,
                                  width: 60,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]['country'];

                        // Filter by search
                        if (searchController.text.isNotEmpty &&
                            !name.toLowerCase().contains(
                              searchController.text.toLowerCase(),
                            )) {
                          return SizedBox(); // Don't show this item
                        }

                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CountryDetailScreen(
                                      image: snapshot
                                          .data![index]['countryInfo']['flag'],
                                      name: snapshot.data![index]['country'],
                                      totalCases:
                                          snapshot.data![index]['cases'],
                                      totalDeaths:
                                          snapshot.data![index]['deaths'],
                                      totalRecovered:
                                          snapshot.data![index]['recovered'],
                                      active: snapshot.data![index]['active'],
                                      critical:
                                          snapshot.data![index]['critical'],
                                      todayRecovered:
                                          snapshot.data![index]['recovered'],
                                      test: snapshot.data![index]['tests'],
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                title: Text(
                                  name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18,
                                  ),
                                ),
                                subtitle: Text(
                                  snapshot.data![index]['cases'].toString(),
                                ),
                                leading: Image(
                                  height: 60,
                                  width: 60,
                                  image: NetworkImage(
                                    snapshot
                                        .data![index]['countryInfo']['flag'],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
