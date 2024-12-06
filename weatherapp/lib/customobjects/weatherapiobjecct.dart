import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Weather> fetchWeather() async {
  try {
    final response =
        await http.get(Uri.parse('https://mr-api-three.vercel.app/weather'));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Weather');
    }
  } catch (e) {
    print('Error fetching weather: $e');
    rethrow;
  }
}

class Weather {
  final Location location;
  final WeatherDetails weather;

  const Weather({
    required this.location,
    required this.weather,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      weather: WeatherDetails.fromJson(json['weather'] as Map<String, dynamic>),
    );
  }
}

class Location {
  final String city;
  final double latitude;
  final double longitude;

  const Location({
    required this.city,
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      city: json['city'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }
}

class WeatherDetails {
  final int temperature;
  final int feelsLike;
  final String condition;
  final int riskFactor;
  final int precipitationProbability;
  final int windSpeed;
  final String windDirection;
  final int atmPressure;
  final int humidity;

  const WeatherDetails({
    required this.temperature,
    required this.feelsLike,
    required this.condition,
    required this.riskFactor,
    required this.precipitationProbability,
    required this.windSpeed,
    required this.windDirection,
    required this.atmPressure,
    required this.humidity,
  });

  factory WeatherDetails.fromJson(Map<String, dynamic> json) {
    return WeatherDetails(
      temperature: json['temperature'] as int,
      feelsLike: json['feels_like'] as int,
      condition: json['condition'] as String,
      riskFactor: json['risk_factor'] as int,
      precipitationProbability: json['precipitation_probability'] as int,
      windSpeed: json['wind_speed'] as int,
      windDirection: json['wind_direction'] as String,
      atmPressure: json['atm_pressure'] as int,
      humidity: json['humidity'] as int,
    );
  }
}
