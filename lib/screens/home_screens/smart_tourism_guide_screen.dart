import 'package:flutter/material.dart';
import 'package:autour_mobile/utils/colors.dart';
import 'package:autour_mobile/widgets/text_widget.dart';
import 'package:autour_mobile/widgets/button_widget.dart';

class SmartTourismGuideScreen extends StatefulWidget {
  const SmartTourismGuideScreen({super.key});

  @override
  State<SmartTourismGuideScreen> createState() =>
      _SmartTourismGuideScreenState();
}

class _SmartTourismGuideScreenState extends State<SmartTourismGuideScreen> {
  String selectedActivity = 'All Activities';

  final List<Map<String, dynamic>> activities = [
    {
      'name': 'Surfing',
      'icon': Icons.surfing,
      'color': Colors.blue,
      'locations': ['Coastal zones', 'Surf spots'],
      'risk_level': 'High',
      'alerts': [
        'Rip current safety tips',
        'Tsunami evacuation routes',
        'Weather alert (e.g., storm surge)',
        'First aid for jellyfish stings',
      ],
      'active_alerts': [
        {
          'type': 'Weather',
          'message': 'Strong currents detected at Baler Bay',
          'severity': 'High',
          'time': '2 hours ago',
        }
      ],
    },
    {
      'name': 'Mountain Hiking',
      'icon': Icons.terrain,
      'color': Colors.green,
      'locations': ['Mountain trails', 'Forested areas'],
      'risk_level': 'Medium',
      'alerts': [
        'Landslide risk alerts',
        'Trail safety protocols',
        'Emergency shelter locations',
        'Snake bite first aid',
      ],
      'active_alerts': [
        {
          'type': 'Trail',
          'message': 'Trail maintenance in progress - Use alternate route',
          'severity': 'Medium',
          'time': '1 hour ago',
        }
      ],
    },
    {
      'name': 'Trekking',
      'icon': Icons.hiking,
      'color': Colors.orange,
      'locations': ['Eco-trails', 'River paths'],
      'risk_level': 'Medium',
      'alerts': [
        'Flash flood warnings',
        'Trail markers and safe zones',
        'Wildlife encounter protocols',
        'Emergency contact access',
      ],
      'active_alerts': [],
    },
    {
      'name': 'Camping',
      'icon': Icons.cabin,
      'color': Colors.brown,
      'locations': ['Designated campgrounds'],
      'risk_level': 'Low',
      'alerts': [
        'Fire safety reminders',
        'Weather-based alerts (e.g., thunderstorms)',
        'Nearby rescue stations',
      ],
      'active_alerts': [
        {
          'type': 'Weather',
          'message': 'Thunderstorm warning for tonight',
          'severity': 'Medium',
          'time': '30 minutes ago',
        }
      ],
    },
    {
      'name': 'Biking',
      'icon': Icons.pedal_bike,
      'color': Colors.purple,
      'locations': ['Adventure routes', 'Off-road paths'],
      'risk_level': 'Medium',
      'alerts': [
        'Road hazard alerts',
        'Heatstroke prevention tips',
        'Nearest medical stations',
      ],
      'active_alerts': [],
    },
    {
      'name': 'Boating/Kayaking',
      'icon': Icons.directions_boat,
      'color': Colors.cyan,
      'locations': ['Rivers', 'Lakes', 'Coastal waters'],
      'risk_level': 'High',
      'alerts': [
        'Capsizing protocols',
        'Life vest reminders',
        'Weather and tide updates',
      ],
      'active_alerts': [
        {
          'type': 'Safety',
          'message': 'High tide warning - Avoid coastal activities',
          'severity': 'High',
          'time': '45 minutes ago',
        }
      ],
    },
    {
      'name': 'Swimming',
      'icon': Icons.pool,
      'color': Colors.lightBlue,
      'locations': ['Waterfalls', 'Rivers', 'Beaches'],
      'risk_level': 'High',
      'alerts': [
        'Flash flood and sudden water surge alerts',
        'Slippery rock and drowning risks',
        'Water quality warnings (e.g., contamination)',
        'Nearest lifeguard or rescue station',
      ],
      'active_alerts': [
        {
          'type': 'Water Quality',
          'message': 'Water quality alert at Mother Falls',
          'severity': 'Medium',
          'time': '1 hour ago',
        }
      ],
    },
    {
      'name': 'Picnic',
      'icon': Icons.table_bar,
      'color': Colors.pink,
      'locations': ['Waterfall zones', 'Riverside parks'],
      'risk_level': 'Low',
      'alerts': [
        'Rockfall and landslide alerts',
        'Fire safety (for cooking)',
        'Waste disposal reminders',
        'Emergency exit routes and shelter areas',
      ],
      'active_alerts': [],
    },
  ];

  List<Map<String, dynamic>> get filteredActivities {
    if (selectedActivity == 'All Activities') {
      return activities;
    }
    return activities
        .where((activity) => activity['name'] == selectedActivity)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
        title: TextWidget(
          text: 'Smart Tourism Guide',
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
            icon: const Icon(Icons.notifications, color: white),
            onPressed: () {
              _showAllAlerts();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Header with Safety Overview
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: primary.withOpacity(0.1),
              border: Border(
                bottom: BorderSide(color: primary.withOpacity(0.2)),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.safety_divider,
                      color: primary,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    TextWidget(
                      text: 'Risk Detection & Safety Alerts',
                      fontSize: 16,
                      color: black,
                      fontFamily: 'Bold',
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TextWidget(
                  text:
                      'Real-time safety notifications for your activities in Aurora',
                  fontSize: 12,
                  color: grey,
                  fontFamily: 'Regular',
                ),
              ],
            ),
          ),

          // Activity Filter
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: [
                'All Activities',
                ...activities.map((a) => a['name']).toList()
              ].length,
              itemBuilder: (context, index) {
                final activity = index == 0
                    ? 'All Activities'
                    : activities[index - 1]['name'];
                final isSelected = selectedActivity == activity;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedActivity = activity;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected ? primary : grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: isSelected ? primary : grey),
                      ),
                      child: TextWidget(
                        text: activity,
                        fontSize: 12,
                        color: isSelected ? white : black,
                        fontFamily: isSelected ? 'Bold' : 'Regular',
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Activities List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredActivities.length,
              itemBuilder: (context, index) {
                final activity = filteredActivities[index];
                return _buildActivityCard(activity);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard(Map<String, dynamic> activity) {
    final activeAlerts = activity['active_alerts'] as List<dynamic>;
    final hasActiveAlerts = activeAlerts.isNotEmpty;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
          color: hasActiveAlerts
              ? Colors.red.withOpacity(0.3)
              : activity['color'].withOpacity(0.3),
          width: hasActiveAlerts ? 2 : 1,
        ),
      ),
      child: Column(
        children: [
          // Activity Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: activity['color'].withOpacity(0.1),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: activity['color'].withOpacity(0.2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Icon(
                    activity['icon'],
                    color: activity['color'],
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: activity['name'],
                        fontSize: 18,
                        color: black,
                        fontFamily: 'Bold',
                      ),
                      const SizedBox(height: 4),
                      TextWidget(
                        text: 'Risk Level: ${activity['risk_level']}',
                        fontSize: 12,
                        color: _getRiskColor(activity['risk_level']),
                        fontFamily: 'Bold',
                      ),
                      const SizedBox(height: 4),
                      TextWidget(
                        text: activity['locations'].join(', '),
                        fontSize: 12,
                        color: grey,
                        fontFamily: 'Regular',
                      ),
                    ],
                  ),
                ),
                if (hasActiveAlerts)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextWidget(
                      text:
                          '${activeAlerts.length} Alert${activeAlerts.length > 1 ? 's' : ''}',
                      fontSize: 10,
                      color: Colors.red,
                      fontFamily: 'Bold',
                    ),
                  ),
              ],
            ),
          ),

          // Active Alerts
          if (hasActiveAlerts) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.05),
                border: Border(
                  top: BorderSide(color: Colors.red.withOpacity(0.2)),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: Colors.red,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      TextWidget(
                        text: 'Active Alerts',
                        fontSize: 14,
                        color: Colors.red,
                        fontFamily: 'Bold',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ...activeAlerts
                      .map((alert) => _buildAlertItem(alert))
                      .toList(),
                ],
              ),
            ),
          ],

          // Safety Tips
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: 'Safety Guidelines',
                  fontSize: 14,
                  color: black,
                  fontFamily: 'Bold',
                ),
                const SizedBox(height: 8),
                ...(activity['alerts'] as List<String>)
                    .map(
                      (tip) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: primary,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextWidget(
                                text: tip,
                                fontSize: 12,
                                color: grey,
                                fontFamily: 'Regular',
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ButtonWidget(
                        label: 'View Details',
                        onPressed: () => _showActivityDetails(activity),
                        color: activity['color'],
                        textColor: white,
                        height: 36,
                        radius: 8,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ButtonWidget(
                      label: 'Emergency',
                      onPressed: () => _showEmergencyContacts(activity),
                      color: Colors.red,
                      textColor: white,
                      height: 36,
                      radius: 8,
                      fontSize: 12,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertItem(Map<String, dynamic> alert) {
    Color severityColor;
    switch (alert['severity']) {
      case 'High':
        severityColor = Colors.red;
        break;
      case 'Medium':
        severityColor = Colors.orange;
        break;
      default:
        severityColor = Colors.yellow;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: severityColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: severityColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber,
            color: severityColor,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: alert['message'],
                  fontSize: 12,
                  color: black,
                  fontFamily: 'Medium',
                ),
                TextWidget(
                  text: '${alert['type']} • ${alert['time']}',
                  fontSize: 10,
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

  Color _getRiskColor(String riskLevel) {
    switch (riskLevel) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return grey;
    }
  }

  void _showActivityDetails(Map<String, dynamic> activity) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(activity['icon'], color: activity['color']),
            const SizedBox(width: 8),
            TextWidget(
              text: activity['name'],
              fontSize: 18,
              color: black,
              fontFamily: 'Bold',
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              text: 'Locations:',
              fontSize: 14,
              color: black,
              fontFamily: 'Bold',
            ),
            const SizedBox(height: 4),
            ...activity['locations'].map(
              (location) => Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: TextWidget(
                  text: '• $location',
                  fontSize: 12,
                  color: grey,
                  fontFamily: 'Regular',
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextWidget(
              text: 'Safety Guidelines:',
              fontSize: 14,
              color: black,
              fontFamily: 'Bold',
            ),
            const SizedBox(height: 4),
            ...(activity['alerts'] as List<String>).map(
              (tip) => Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: TextWidget(
                  text: '• $tip',
                  fontSize: 12,
                  color: grey,
                  fontFamily: 'Regular',
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: TextWidget(
              text: 'Close',
              fontSize: 14,
              color: primary,
              fontFamily: 'Medium',
            ),
          ),
        ],
      ),
    );
  }

  void _showEmergencyContacts(Map<String, dynamic> activity) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.emergency, color: Colors.red),
            const SizedBox(width: 8),
            TextWidget(
              text: 'Emergency Contacts',
              fontSize: 18,
              color: black,
              fontFamily: 'Bold',
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildEmergencyContact('Police', '117'),
            _buildEmergencyContact('Fire Department', '118'),
            _buildEmergencyContact('Ambulance', '119'),
            _buildEmergencyContact('Coast Guard', '+639123456789'),
            _buildEmergencyContact('Local Rescue', '+639123456790'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: TextWidget(
              text: 'Close',
              fontSize: 14,
              color: primary,
              fontFamily: 'Medium',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyContact(String name, String number) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            text: name,
            fontSize: 14,
            color: black,
            fontFamily: 'Medium',
          ),
          TextWidget(
            text: number,
            fontSize: 14,
            color: Colors.red,
            fontFamily: 'Bold',
          ),
        ],
      ),
    );
  }

  void _showAllAlerts() {
    final allAlerts = activities
        .expand((activity) =>
            (activity['active_alerts'] as List<dynamic>).map((alert) => {
                  'activity': activity['name'],
                  'alert': alert,
                }))
        .toList();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: TextWidget(
          text: 'All Active Alerts',
          fontSize: 18,
          color: black,
          fontFamily: 'Bold',
        ),
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: allAlerts.isEmpty
                ? [
                    TextWidget(
                      text: 'No active alerts at the moment.',
                      fontSize: 14,
                      color: grey,
                      fontFamily: 'Regular',
                    ),
                  ]
                : allAlerts
                    .map(
                      (item) => Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              text:
                                  '${item['activity']} - ${item['alert']['type']}',
                              fontSize: 12,
                              color: black,
                              fontFamily: 'Bold',
                            ),
                            TextWidget(
                              text: item['alert']['message'],
                              fontSize: 11,
                              color: grey,
                              fontFamily: 'Regular',
                            ),
                            TextWidget(
                              text: item['alert']['time'],
                              fontSize: 10,
                              color: grey,
                              fontFamily: 'Regular',
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: TextWidget(
              text: 'Close',
              fontSize: 14,
              color: primary,
              fontFamily: 'Medium',
            ),
          ),
        ],
      ),
    );
  }
}
