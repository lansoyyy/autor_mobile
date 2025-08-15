import 'package:flutter/material.dart';
import 'package:autour_mobile/utils/colors.dart';
import 'package:autour_mobile/widgets/text_widget.dart';
import 'package:autour_mobile/widgets/button_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class DisasterPreparednessScreen extends StatelessWidget {
  const DisasterPreparednessScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              // Firestore streams auto-update; show a sync toast
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: TextWidget(
                    text: 'Synced with latest admin data',
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
              // Current Weather (admin-managed at current_weather; take latest by updatedAt)
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('current_weather')
                    .orderBy('updatedAt', descending: true)
                    .limit(1)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return _buildInfoBanner(
                        icon: Icons.error_outline,
                        color: Colors.red,
                        title: 'Failed to load weather',
                        message: 'Please try again later.');
                  }
                  final docs = snapshot.data?.docs ?? [];
                  if (docs.isEmpty) {
                    return _buildInfoBanner(
                        icon: Icons.cloud_off,
                        color: Colors.grey,
                        title: 'Weather Unavailable',
                        message:
                            'No weather data from admin yet. Please check back later.');
                  }
                  final weatherData = _mapWeatherData(
                      docs.first.data() as Map<String, dynamic>);
                  return _buildCurrentWeatherCard(weatherData);
                },
              ),

              const SizedBox(height: 20),

              // Weather Details (same source as above)
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('current_weather')
                    .orderBy('updatedAt', descending: true)
                    .limit(1)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox();
                  }
                  if (snapshot.hasError) {
                    return const SizedBox();
                  }
                  final docs = snapshot.data?.docs ?? [];
                  if (docs.isEmpty) {
                    return const SizedBox();
                  }
                  final weatherData = _mapWeatherData(
                      docs.first.data() as Map<String, dynamic>);
                  return _buildWeatherDetailsCard(weatherData);
                },
              ),

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

              // Admin AI suggestions (collection: ai_suggestions)
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('ai_suggestions')
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return _buildInfoBanner(
                        icon: Icons.error_outline,
                        color: Colors.red,
                        title: 'Failed to load suggestions',
                        message:
                            'Please check your connection or try again later.');
                  }
                  final docs = snapshot.data?.docs ?? [];
                  if (docs.isEmpty) {
                    return _buildInfoBanner(
                        icon: Icons.psychology_alt,
                        color: Colors.grey,
                        title: 'No insights yet',
                        message: 'Admin has not posted any suggestions yet.');
                  }
                  final suggestions = docs
                      .map((d) => _mapAlert(d.data() as Map<String, dynamic>))
                      .toList();
                  return Column(
                    children: suggestions
                        .map((s) => _buildAISuggestionCard(s))
                        .toList(),
                  );
                },
              ),

              const SizedBox(height: 20),

              // Emergency quick actions (uses admin settings if available)
              _buildEmergencyActionsCard(context),
            ],
          ),
        ),
      ),
    );
  }

  // Map Firestore weather doc (snake_case from admin) to display strings
  Map<String, String> _mapWeatherData(Map<String, dynamic> data) {
    String withUnit(dynamic v, String unit) =>
        (v == null || v.toString().isEmpty) ? '-' : '${v.toString()}$unit';
    String _capFirst(String s) =>
        s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
    String _fmtUnix(dynamic ts) {
      if (ts == null) return '-';
      int? val;
      if (ts is int) val = ts;
      if (ts is num) val = ts.toInt();
      if (val == null || val <= 0) return '-';
      final dt = DateTime.fromMillisecondsSinceEpoch(val * 1000).toLocal();
      final h = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
      final m = dt.minute.toString().padLeft(2, '0');
      final ampm = dt.hour >= 12 ? 'PM' : 'AM';
      return '$h:$m $ampm';
    }

    final condition = (data['condition'] ?? '-').toString();
    final precip1h = data['precipitation_mm_1h'];
    final precipStr = (precip1h == null || precip1h.toString().isEmpty)
        ? '-'
        : '${precip1h.toString()} mm (1h)';
    return {
      'location': (data['region'] ?? 'Aurora, PH').toString(),
      'temperature': withUnit(data['temperature_c'], '°C'),
      'feels_like': withUnit(data['feels_like_c'], '°C'),
      'condition': _capFirst(condition),
      'humidity': withUnit(data['humidity'], '%'),
      'wind_speed': withUnit(data['wind_kmh'], ' km/h'),
      'visibility': withUnit(data['visibility_km'], ' km'),
      'uv_index': '-',
      'sunrise': _fmtUnix(data['sunrise_unix']),
      'sunset': _fmtUnix(data['sunset_unix']),
      'precipitation': precipStr,
      'pressure': withUnit(data['pressure_hpa'], ' hPa'),
    };
  }

  // Map Firestore AI suggestion to UI-friendly map
  Map<String, dynamic> _mapAlert(Map<String, dynamic> data) {
    final String priority =
        (data['priority'] ?? 'low').toString().toLowerCase();
    final Color color = _priorityColor(priority);
    final String iconName = (data['icon'] ?? 'info').toString();
    return {
      'title': (data['title'] ?? 'Alert').toString(),
      'message': (data['message'] ?? '').toString(),
      'icon': _iconFromName(iconName),
      'color': color,
      'priority': priority,
    };
  }

  Color _priorityColor(String priority) {
    switch (priority) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      default:
        return Colors.green;
    }
  }

  IconData _iconFromName(String name) {
    switch (name.toLowerCase()) {
      case 'cloud':
        return Icons.cloud;
      case 'sunny':
      case 'wb_sunny':
        return Icons.wb_sunny;
      case 'rain':
      case 'umbrella':
        return Icons.umbrella;
      case 'warning':
        return Icons.warning;
      case 'health':
      case 'health_and_safety':
        return Icons.health_and_safety;
      case 'beach':
      case 'beach_access':
        return Icons.beach_access;
      default:
        return Icons.psychology_alt;
    }
  }

  Widget _buildInfoBanner({
    required IconData icon,
    required Color color,
    required String title,
    required String message,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: title,
                  fontSize: 16,
                  color: black,
                  fontFamily: 'Bold',
                ),
                const SizedBox(height: 4),
                TextWidget(
                  text: message,
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

  Widget _buildEmergencyActionsCard(BuildContext context) {
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
                    _launchEmergencyCall();
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
                    _showAlertsSheet(context);
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

  void _showAlertsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.campaign, color: Colors.orange),
                    const SizedBox(width: 8),
                    TextWidget(
                      text: 'Weather Alerts',
                      fontSize: 18,
                      color: black,
                      fontFamily: 'Bold',
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('ai_suggestions')
                        .orderBy('createdAt', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: TextWidget(
                            text: 'Failed to load suggestions',
                            fontSize: 14,
                            color: grey,
                            fontFamily: 'Regular',
                          ),
                        );
                      }
                      final docs = snapshot.data?.docs ?? [];
                      if (docs.isEmpty) {
                        return Center(
                          child: TextWidget(
                            text: 'No suggestions available',
                            fontSize: 14,
                            color: grey,
                            fontFamily: 'Regular',
                          ),
                        );
                      }
                      return ListView.separated(
                        itemCount: docs.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final mapped = _mapAlert(
                              docs[index].data() as Map<String, dynamic>);
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: mapped['color'].withOpacity(0.1),
                              child:
                                  Icon(mapped['icon'], color: mapped['color']),
                            ),
                            title: TextWidget(
                              text: mapped['title'],
                              fontSize: 14,
                              color: black,
                              fontFamily: 'Bold',
                            ),
                            subtitle: TextWidget(
                              text: mapped['message'],
                              fontSize: 12,
                              color: grey,
                              fontFamily: 'Regular',
                            ),
                            trailing: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: _priorityColor(mapped['priority'])
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextWidget(
                                text:
                                    mapped['priority'].toString().toUpperCase(),
                                fontSize: 10,
                                color: _priorityColor(mapped['priority']),
                                fontFamily: 'Bold',
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Launch admin-configured emergency number, with fallback
  Future<void> _launchEmergencyCall() async {
    String fallbackNumber = '911';
    try {
      final doc = await FirebaseFirestore.instance
          .collection('settings')
          .doc('emergency')
          .get();
      final number =
          (doc.data()?['defaultNumber'] ?? fallbackNumber).toString().trim();
      final uri = Uri(scheme: 'tel', path: number);
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      final uri = Uri(scheme: 'tel', path: fallbackNumber);
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
