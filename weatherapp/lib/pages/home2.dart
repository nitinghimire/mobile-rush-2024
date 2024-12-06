import 'package:flutter/material.dart';
import 'package:weatherapp/customobjects/weatherapiobjecct.dart';

class Home2 extends StatefulWidget {
  const Home2({super.key});

  @override
  State<Home2> createState() => _HomeState();
}

class _HomeState extends State<Home2> {
  // late Future<Weather> weather;

  @override
  void initState() {
    super.initState();
    // weather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("SnowyBackground.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.white,
                ),
                Text(
                  "Kathmandu",
                  style: TextStyle(
                    color: Colors.white,
                    // fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "40",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                VerticalDivider(
                  color: Color.fromARGB(255, 0, 0, 0),
                  width: 1,
                  indent: 1,
                  endIndent: 2,
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Text(
                      "Sunny",
                      style: TextStyle(
                        color: Colors.white,
                        // fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Friday 6 December",
                      style: TextStyle(
                        color: Colors.white,
                        // fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Feels Like 42",
              style: TextStyle(
                color: Colors.white,
                // fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: 100, // Ensuring the container has height
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    spreadRadius: 0,
                    color: Color(0xffDBE3FB),
                  ),
                ],
                borderRadius: BorderRadius.circular(5),
              ),
              child: GridView.count(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 5, // Spacing between columns
                mainAxisSpacing: 5, // Spacing between rows
                children: List.generate(4, (index) {
                  return Container(
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 227, 237, 255),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Item ',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
