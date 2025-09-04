import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'weather_config.dart';
import 'alert_models.dart';

class WeatherService {
  /// Fetch weather data for a specific location
  static Future<Map<String, dynamic>?> fetchWeatherData(
      double lat, double lon) async {
    if (WeatherConfig.weatherApiKey.isEmpty) {
      print('Missing OpenWeather API key');
      return null;
    }

    final uri = Uri.parse(
        '${WeatherConfig.weatherApiEndpoint}?lat=$lat&lon=$lon&appid=${WeatherConfig.weatherApiKey}&units=metric');

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        return data;
      } else {
        print('Failed to fetch weather data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching weather data: $e');
      return null;
    }
  }

  /// Check if weather conditions are dangerous for a specific location
  static Future<List<ActiveAlert>> checkWeatherAlerts(
      Position position, List<TouristActivity> activities) async {
    List<ActiveAlert> weatherAlerts = [];

    try {
      final weatherData =
          await fetchWeatherData(position.latitude, position.longitude);
      if (weatherData == null) return weatherAlerts;

      // Extract relevant weather information
      final weatherDescription =
          (weatherData['weather']?[0]?['description'] ?? '').toString();
      final double windSpeed = (weatherData['wind']?['speed'] ?? 0).toDouble() *
          3.6; // Convert m/s to km/h
      final int humidity = (weatherData['main']?['humidity'] ?? 0).toInt();

      // Check for precipitation
      double precipitation = 0.0;
      if (weatherData['rain'] != null && weatherData['rain']['1h'] != null) {
        precipitation = (weatherData['rain']['1h'] as num).toDouble();
      }

      // Check for dangerous weather conditions
      bool hasHighWind = windSpeed >= WeatherConfig.highWindThreshold;
      bool hasHeavyRain = precipitation >= WeatherConfig.heavyRainThreshold;
      bool hasHighHumidity = humidity >= WeatherConfig.highHumidityThreshold;

      // Generate alerts based on weather conditions and activities
      if (hasHighWind || hasHeavyRain || hasHighHumidity) {
        // Find activities that might be affected by these conditions
        for (var activity in activities) {
          bool shouldAlert = false;
          String alertMessage = '';
          String severity = 'Low';

          // Check if activity is affected by current weather
          if (activity.name.contains('Surfing') &&
              (hasHighWind || hasHeavyRain)) {
            shouldAlert = true;
            alertMessage =
                'Strong winds and/or heavy rain reported. Surfing conditions may be dangerous.';
            severity = hasHighWind ? 'High' : 'Medium';
          } else if (activity.name.contains('Waterfall') && hasHeavyRain) {
            shouldAlert = true;
            alertMessage =
                'Heavy rain reported. Waterfall trekking may be dangerous due to slippery trails and rising water levels.';
            severity = 'High';
          } else if (activity.name.contains('Hiking') &&
              (hasHeavyRain || hasHighWind)) {
            shouldAlert = true;
            alertMessage =
                'Adverse weather conditions reported. Hiking may be dangerous due to slippery trails and strong winds.';
            severity = hasHeavyRain ? 'High' : 'Medium';
          } else if (activity.name.contains('Beach') &&
              (hasHighWind || hasHeavyRain)) {
            shouldAlert = true;
            alertMessage =
                'Bad weather conditions at beach. Swimming and beach activities may be dangerous.';
            severity = hasHighWind ? 'High' : 'Medium';
          } else if (hasHeavyRain &&
              (activity.riskLevel == 'High' ||
                  activity.riskLevel == 'Medium')) {
            shouldAlert = true;
            alertMessage =
                'Heavy rain reported. ${activity.name} may be dangerous in current conditions.';
            severity = 'Medium';
          }

          if (shouldAlert) {
            weatherAlerts.add(ActiveAlert(
              type: 'Weather',
              message: alertMessage,
              severity: severity,
              time: 'Just now',
            ));
          }
        }
      }
    } catch (e) {
      print('Error checking weather alerts: $e');
    }

    return weatherAlerts;
  }

  /// Get a simple weather description for display
  static Future<String> getCurrentWeatherDescription(Position position) async {
    try {
      final weatherData =
          await fetchWeatherData(position.latitude, position.longitude);
      if (weatherData == null) return 'Weather data unavailable';

      final weatherDescription =
          (weatherData['weather']?[0]?['description'] ?? '').toString();
      final double temp = (weatherData['main']?['temp'] ?? 0).toDouble();

      return '${weatherDescription.capitalize()}, ${temp.toStringAsFixed(1)}°C';
    } catch (e) {
      return 'Weather data unavailable';
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    return isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
  }
}
