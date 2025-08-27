import 'package:flutter/material.dart';

class TouristDestination {
  final String name;
  final String municipality;
  final double latitude;
  final double longitude;
  final String description;
  final List<String> activities;
  final String hours;
  final String fees;
  final List<String> tips;

  TouristDestination({
    required this.name,
    required this.municipality,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.activities,
    required this.hours,
    required this.fees,
    required this.tips,
  });

  // Convert from JSON
  factory TouristDestination.fromJson(Map<String, dynamic> json) {
    return TouristDestination(
      name: json['name'] as String,
      municipality: json['municipality'] as String,
      latitude: (json['lat'] as num).toDouble(),
      longitude: (json['lng'] as num).toDouble(),
      description: json['description'] as String,
      activities: List<String>.from(json['activities'] as List),
      hours: json['hours'] as String,
      fees: json['fees'] as String,
      tips: List<String>.from(json['tips'] as List),
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'municipality': municipality,
      'lat': latitude,
      'lng': longitude,
      'description': description,
      'activities': activities,
      'hours': hours,
      'fees': fees,
      'tips': tips,
    };
  }
}

class TouristActivity {
  final String name;
  final IconData icon;
  final Color color;
  final List<String> locations;
  final String riskLevel; // High, Medium, Low
  final List<String> alerts;
  final List<ActiveAlert> activeAlerts;

  TouristActivity({
    required this.name,
    required this.icon,
    required this.color,
    required this.locations,
    required this.riskLevel,
    required this.alerts,
    required this.activeAlerts,
  });

  // Convert from JSON-like map
  factory TouristActivity.fromMap(Map<String, dynamic> map) {
    List<ActiveAlert> activeAlertsList = [];
    if (map['active_alerts'] != null) {
      activeAlertsList = (map['active_alerts'] as List)
          .map((alert) => ActiveAlert.fromMap(alert as Map<String, dynamic>))
          .toList();
    }

    return TouristActivity(
      name: map['name'] as String,
      icon: map['icon'] as IconData,
      color: map['color'] as Color,
      locations: List<String>.from(map['locations'] as List),
      riskLevel: map['risk_level'] as String,
      alerts: List<String>.from(map['alerts'] as List),
      activeAlerts: activeAlertsList,
    );
  }
}

class ActiveAlert {
  final String type; // Weather, Trail, Safety, Tide
  final String message;
  final String severity; // High, Medium, Low
  final String time; // Timestamp

  ActiveAlert({
    required this.type,
    required this.message,
    required this.severity,
    required this.time,
  });

  // Convert from JSON-like map
  factory ActiveAlert.fromMap(Map<String, dynamic> map) {
    return ActiveAlert(
      type: map['type'] as String,
      message: map['message'] as String,
      severity: map['severity'] as String,
      time: map['time'] as String,
    );
  }
}