import 'package:flutter/material.dart';
import 'package:weatherapp/customobjects/weatherapiobjecct.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<Weather> weather;

  @override
  void initState() {
    super.initState();
    weather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Weather>(
        future: weather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final weatherData = snapshot.data!;
            return buildWeatherUI(weatherData);
          } else {
            return Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }

  Widget buildWeatherUI(Weather weather) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("SnowyBackground.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on),
              Text(weather.location.city),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${weather.weather.temperature}° Celsius'),
              VerticalDivider(
                color: const Color.fromARGB(255, 0, 0, 0),
                width: 1,
              ),
              Column(
                children: [
                  Text(weather.weather.condition),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
