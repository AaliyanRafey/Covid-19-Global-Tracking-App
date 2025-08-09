import 'package:covid_19_api_application/views/worlds_stats.dart';
import 'package:flutter/material.dart';

class CountryDetailScreen extends StatefulWidget {
  final String image;
  final String name;
  final int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;

  const CountryDetailScreen({
    super.key,
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
  });

  @override
  State<CountryDetailScreen> createState() => _CountryDetailScreenState();
}

class _CountryDetailScreenState extends State<CountryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name, style: TextStyle(fontWeight: FontWeight.w900)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),

            // Profile Circle
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(widget.image),
                radius: 50,
              ),
            ),

            const SizedBox(height: 16),

            // Card with Data
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 20.0,
                  ),
                  child: Column(
                    children: [
                      ResusableRow(title: 'Country', value: widget.name),
                      ResusableRow(
                        title: 'Cases',
                        value: widget.totalCases.toString(),
                      ),
                      ResusableRow(
                        title: 'Recovered',
                        value: widget.totalRecovered.toString(),
                      ),
                      ResusableRow(
                        title: 'Deaths',
                        value: widget.totalDeaths.toString(),
                      ),
                      ResusableRow(
                        title: 'Today Recovered',
                        value: widget.todayRecovered.toString(),
                      ),
                      ResusableRow(
                        title: 'Tests',
                        value: widget.test.toString(),
                      ),
                      ResusableRow(
                        title: 'Active',
                        value: widget.active.toString(),
                      ),
                      ResusableRow(
                        title: 'Critical',
                        value: widget.critical.toString(),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
