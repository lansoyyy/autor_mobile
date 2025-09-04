// Weather API Configuration
class WeatherConfig {
  // OpenWeather API endpoint
  static const String weatherApiEndpoint =
      'https://api.openweathermap.org/data/2.5/weather';

  // OpenWeather API key - should be set in environment or secure storage
  // For demo purposes, this can be set directly, but in production use secure storage
  static const String weatherApiKey = String.fromEnvironment(
      '67a96ca939095cc12748c226c7d3851c',
      defaultValue: '67a96ca939095cc12748c226c7d3851c');

  // Aurora Province coordinates (central point)
  static const double auroraLat =
      15.8333; // Approximate center of Aurora Province
  static const double auroraLon = 121.5000;
  static const String auroraLocationLabel = 'Aurora Province, Philippines';

  // Weather condition thresholds for alerts
  static const double highWindThreshold = 15.0; // km/h
  static const double heavyRainThreshold = 5.0; // mm/h
  static const int highHumidityThreshold = 80; // percentage
}
