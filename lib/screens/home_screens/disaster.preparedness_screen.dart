import 'package:flutter/material.dart';
import 'package:autour_mobile/utils/colors.dart';
import 'package:autour_mobile/widgets/text_widget.dart';
import 'package:autour_mobile/widgets/button_widget.dart';

class DisasterPreparednessScreen extends StatelessWidget {
  const DisasterPreparednessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock weather data
    final weatherData = {
      'location': 'Baler, Aurora',
      'temperature': '28°C',
      'feels_like': '32°C',
      'condition': 'Partly Cloudy',
      'humidity': '75%',
      'wind_speed': '15 km/h',
      'visibility': '10 km',
      'uv_index': 'High',
      'sunrise': '5:45 AM',
      'sunset': '6:15 PM',
      'precipitation': '20%',
      'pressure': '1013 hPa',
    };

    final aiSuggestions = [
      {
        'title': 'Weather Advisory',
        'message':
            'Light rain expected in the afternoon. Carry an umbrella and avoid outdoor activities during heavy showers.',
        'icon': Icons.cloud,
        'color': Colors.blue,
        'priority': 'medium',
      },
      {
        'title': 'UV Protection',
        'message':
            'High UV index detected. Apply sunscreen with SPF 30+ and limit sun exposure between 10 AM - 4 PM.',
        'icon': Icons.wb_sunny,
        'color': Colors.orange,
        'priority': 'high',
      },
      {
        'title': 'Outdoor Activities',
        'message':
            'Weather is suitable for beach activities. However, be cautious of sudden weather changes.',
        'icon': Icons.beach_access,
        'color': Colors.green,
        'priority': 'low',
      },
      {
        'title': 'Health Reminder',
        'message':
            'High humidity may cause discomfort. Stay hydrated and avoid strenuous outdoor activities.',
        'icon': Icons.health_and_safety,
        'color': Colors.teal,
        'priority': 'medium',
      },
    ];

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
        title: TextWidget(
          text: 'Disaster Preparedness & Weather',
          fontSize: 18,
          color: white,
          fontFamily: 'Bold',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: white),
            onPressed: () {
              // Refresh weather data
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: TextWidget(
                    text: 'Weather data refreshed',
                    fontSize: 14,
                    color: white,
                  ),
                  backgroundColor: primary,
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Current Weather Card
              _buildCurrentWeatherCard(weatherData),

              const SizedBox(height: 20),

              // Weather Details
              _buildWeatherDetailsCard(weatherData),

              const SizedBox(height: 20),

              // AI Suggestions Header
              Row(
                children: [
                  Icon(
                    Icons.psychology,
                    color: primary,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  TextWidget(
                    text: 'AI Weather Insights',
                    fontSize: 20,
                    color: black,
                    fontFamily: 'Bold',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TextWidget(
                text:
                    'Personalized recommendations based on current weather conditions',
                fontSize: 14,
                color: grey,
                fontFamily: 'Regular',
              ),
              const SizedBox(height: 16),

              // AI Suggestions
              ...aiSuggestions
                  .map((suggestion) => _buildAISuggestionCard(suggestion))
                  .toList(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentWeatherCard(Map<String, String> weatherData) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primary.withOpacity(0.1),
            secondary.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: primary.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: weatherData['location']!,
                    fontSize: 18,
                    color: black,
                    fontFamily: 'Bold',
                  ),
                  const SizedBox(height: 4),
                  TextWidget(
                    text: weatherData['condition']!,
                    fontSize: 14,
                    color: grey,
                    fontFamily: 'Regular',
                  ),
                ],
              ),
              Icon(
                Icons.location_on,
                color: primary,
                size: 24,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: weatherData['temperature']!,
                    fontSize: 48,
                    color: black,
                    fontFamily: 'Bold',
                  ),
                  TextWidget(
                    text: 'Feels like ${weatherData['feels_like']}',
                    fontSize: 14,
                    color: grey,
                    fontFamily: 'Regular',
                  ),
                ],
              ),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Icon(
                  Icons.wb_sunny,
                  color: primary,
                  size: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetailsCard(Map<String, String> weatherData) {
    final details = [
      {
        'label': 'Humidity',
        'value': weatherData['humidity']!,
        'icon': Icons.water_drop
      },
      {
        'label': 'Wind Speed',
        'value': weatherData['wind_speed']!,
        'icon': Icons.air
      },
      {
        'label': 'Visibility',
        'value': weatherData['visibility']!,
        'icon': Icons.visibility
      },
      {
        'label': 'UV Index',
        'value': weatherData['uv_index']!,
        'icon': Icons.wb_sunny
      },
      {
        'label': 'Precipitation',
        'value': weatherData['precipitation']!,
        'icon': Icons.cloud
      },
      {
        'label': 'Pressure',
        'value': weatherData['pressure']!,
        'icon': Icons.speed
      },
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: 'Weather Details',
            fontSize: 16,
            color: black,
            fontFamily: 'Bold',
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2.5,
            ),
            itemCount: details.length,
            itemBuilder: (context, index) {
              final detail = details[index];
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: grey.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      detail['icon'] as IconData,
                      color: primary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: detail['label'].toString(),
                            fontSize: 12,
                            color: grey,
                            fontFamily: 'Regular',
                          ),
                          TextWidget(
                            text: detail['value'].toString(),
                            fontSize: 14,
                            color: black,
                            fontFamily: 'Bold',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAISuggestionCard(Map<String, dynamic> suggestion) {
    Color priorityColor;
    switch (suggestion['priority']) {
      case 'high':
        priorityColor = Colors.red;
        break;
      case 'medium':
        priorityColor = Colors.orange;
        break;
      default:
        priorityColor = Colors.green;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: suggestion['color'].withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: suggestion['color'].withOpacity(0.1),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              suggestion['icon'],
              color: suggestion['color'],
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TextWidget(
                      text: suggestion['title'],
                      fontSize: 16,
                      color: black,
                      fontFamily: 'Bold',
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: priorityColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextWidget(
                        text: suggestion['priority'].toString().toUpperCase(),
                        fontSize: 10,
                        color: priorityColor,
                        fontFamily: 'Bold',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                TextWidget(
                  text: suggestion['message'],
                  fontSize: 14,
                  color: grey,
                  fontFamily: 'Regular',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyActionsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.emergency,
                color: Colors.red,
                size: 24,
              ),
              const SizedBox(width: 8),
              TextWidget(
                text: 'Emergency Quick Actions',
                fontSize: 16,
                color: black,
                fontFamily: 'Bold',
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ButtonWidget(
                  label: 'Call Emergency',
                  onPressed: () {
                    // Launch emergency call
                  },
                  color: Colors.red,
                  textColor: white,
                  height: 40,
                  radius: 8,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ButtonWidget(
                  label: 'Weather Alert',
                  onPressed: () {
                    // Show weather alerts
                  },
                  color: Colors.orange,
                  textColor: white,
                  height: 40,
                  radius: 8,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
