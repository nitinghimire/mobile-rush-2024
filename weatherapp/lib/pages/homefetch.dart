import 'package:flutter/material.dart';
import 'package:weatherapp/customobjects/weatherapiobjecct.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeFetch extends StatefulWidget {
  const HomeFetch({super.key});

  @override
  State<HomeFetch> createState() => _HomeFetchState();
}

class _HomeFetchState extends State<HomeFetch> {
  late Future<Weather> weather;

  @override
  void initState() {
    super.initState();
    weather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
    return Column(
      // Using Column to allow flexible layout

      children: [
        Container(
          margin: EdgeInsets.only(top: 50),
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/SnowyBackground.png"),
              fit: BoxFit.fitWidth,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on, color: Colors.white),
                  Text(
                    weather.location.city,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${weather.weather.temperature}°',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 20),
                  VerticalDivider(color: Colors.black, width: 1),
                  SizedBox(width: 20),
                  Column(
                    children: [
                      Text(
                        weather.weather.condition,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Friday 6 December",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                "Feels Like ${weather.weather.feelsLike}",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 20,
                        spreadRadius: 0,
                        color: Color(0xffDBE3FB)),
                  ],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: EdgeInsets.only(top: 10),
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  shrinkWrap: true,
                  childAspectRatio: 2,
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(4, (index) {
                    String title = "";
                    String value = "";

                    switch (index) {
                      case 0:
                        title = "Precipitation";
                        value = "${weather.weather.precipitationProbability}%";
                        break;
                      case 1:
                        title = "Wind Speed";
                        value = "${weather.weather.windSpeed} km/h";
                        break;
                      case 2:
                        title = "ATM Pressure";
                        value = "${weather.weather.atmPressure} hPa";
                        break;
                      case 3:
                        title = "Humidity";
                        value = "${weather.weather.humidity}%";
                        break;
                    }

                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 227, 237, 255),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [Icon(Icons.cloud)],
                            ),
                            SizedBox(width: 15),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(value),
                                Text(title),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 10),
              Text(
                getRiskFactorText(weather.weather.riskFactor),
                style: TextStyle(
                  color: const Color.fromARGB(255, 108, 108, 108),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        // ListView builder section placed outside the container, now it takes available space
        Expanded(
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      // Image
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage("assets/Rectangle1.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      // City Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              weather.location.city,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '15 km',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'City full of temples and monkeys',
                              style: TextStyle(
                                fontSize: 14,
                                color: const Color.fromARGB(255, 130, 130, 130),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

String getRiskFactorText(int riskFactor) {
  if (riskFactor >= 80) {
    return "Extremely Sunny";
  } else if (riskFactor >= 60) {
    return "Very Sunny";
  } else if (riskFactor >= 40) {
    return "Partly Sunny";
  } else if (riskFactor >= 20) {
    return "Cloudy";
  } else {
    return "Overcast";
  }
}
