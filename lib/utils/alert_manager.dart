import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vibration/vibration.dart';
import 'alert_models.dart';
import 'location_utils.dart';
import 'weather_service.dart';

class AlertManager {
  // Tourist destinations in Aurora Province
  static final List<TouristDestination> destinations = [
    TouristDestination(
      name: 'Sabang Beach',
      municipality: 'Baler',
      latitude: 15.7580,
      longitude: 121.5660,
      description:
          'Baler\'s iconic surfing spot with a long sandy shore and beginner-friendly waves.',
      activities: ['Surfing', 'Swimming', 'Sunrise/Sunset'],
      hours: 'Open 24/7',
      fees: 'Free (parking/cottage fees may apply)',
      tips: [
        'Beginners should surf near designated areas with instructors.',
        'Beware of rip currents; check local advisories.',
      ],
    ),
    TouristDestination(
      name: 'Ditumabo (Mother) Falls',
      municipality: 'San Luis',
      latitude: 15.6930,
      longitude: 121.5150,
      description:
          'Scenic waterfall reached via a river trek with multiple crossings.',
      activities: ['Trekking', 'Swimming', 'Nature'],
      hours: '7:00 AM – 4:00 PM (weather-dependent)',
      fees: 'Environmental/guide fees apply',
      tips: [
        'Wear proper hiking shoes; expect slippery sections.',
        'Follow LGU/guide instructions, especially during rains.',
      ],
    ),
    TouristDestination(
      name: 'Museo de Baler',
      municipality: 'Baler',
      latitude: 15.7582,
      longitude: 121.5603,
      description:
          'Provincial museum showcasing Aurora\'s history and cultural heritage.',
      activities: ['Museum', 'Heritage', 'Photography'],
      hours: '8:00 AM – 5:00 PM',
      fees: 'Minimal entrance fee',
      tips: [
        'Check holidays and special schedules.',
        'Be respectful of exhibits; no flash when restricted.',
      ],
    ),
    TouristDestination(
      name: 'Ermita Hill',
      municipality: 'Baler',
      latitude: 15.7436,
      longitude: 121.5744,
      description:
          'Historic hill with panoramic views of Baler Bay and townscape.',
      activities: ['Viewdeck', 'Photography', 'Picnic'],
      hours: '6:00 AM – 6:00 PM',
      fees: 'Entrance/parking fees may apply',
      tips: [
        'Best visited early morning or late afternoon.',
        'Mind steps and railings, especially with kids.',
      ],
    ),
    TouristDestination(
      name: 'Digisit Beach & Rock Formations',
      municipality: 'Baler',
      latitude: 15.6929,
      longitude: 121.6499,
      description:
          'Rocky coastline with tidal pools and photogenic formations.',
      activities: ['Tide Pools', 'Photography', 'Beach Walk'],
      hours: 'Open 24/7 (best at low tide)',
      fees: 'Cottage/parking fees may apply',
      tips: [
        'Wear aqua shoes; rocks can be sharp and slippery.',
        'Avoid climbing during strong waves.',
      ],
    ),
    TouristDestination(
      name: 'Aniao Islets',
      municipality: 'Baler',
      latitude: 15.6836,
      longitude: 121.6539,
      description:
          'Twin rock islets just off the coast, visible from Digisit area.',
      activities: ['Boat Tour', 'Photography'],
      hours: 'Weather/tide dependent',
      fees: 'Boat fees apply',
      tips: [
        'Coordinate with accredited boatmen only.',
        'Wear life vests at all times on boats.',
      ],
    ),
    TouristDestination(
      name: 'Millennium (Balete) Tree',
      municipality: 'Maria Aurora',
      latitude: 15.7965,
      longitude: 121.4559,
      description:
          'Ancient balete tree and park area popular for families and nature lovers.',
      activities: ['Nature Park', 'Leisure'],
      hours: '8:00 AM – 5:00 PM',
      fees: 'Entrance fees apply',
      tips: [
        'Watch footing around roots.',
        'Use insect protection.',
      ],
    ),
    TouristDestination(
      name: 'Dinadiawan Beach',
      municipality: 'Dipaculao',
      latitude: 16.2120,
      longitude: 121.6735,
      description: 'Long, serene white-sand stretch with turquoise waters.',
      activities: ['Swimming', 'Snorkeling', 'Camping'],
      hours: 'Open 24/7',
      fees: 'Resort/parking fees may apply',
      tips: [
        'Expect stronger shore break at times.',
        'Swim with caution; few lifeguards available.',
      ],
    ),
    TouristDestination(
      name: 'Dingalan Lighthouse & Viewdeck',
      municipality: 'Dingalan',
      latitude: 15.3890,
      longitude: 121.4140,
      description:
          'Scenic viewpoint overlooking the Pacific and dramatic cliffs.',
      activities: ['Hiking', 'Viewdeck', 'Boat Transfer'],
      hours: 'Daytime (weather/sea-state dependent)',
      fees: 'Guide/boat fees may apply',
      tips: [
        'Check sea state with the Coast Guard before boating.',
        'Beware strong winds along ridges.',
      ],
    ),
    TouristDestination(
      name: 'White Beach (Dingalan)',
      municipality: 'Dingalan',
      latitude: 15.3920,
      longitude: 121.4150,
      description: 'Jump-off area for the lighthouse ridge hike and cove.',
      activities: ['Beach', 'Boat Transfer', 'Hike'],
      hours: 'Daytime (weather-dependent)',
      fees: 'Boat/entrance fees may apply',
      tips: [
        'Secure accredited guides and boats only.',
        'Wear proper footwear for rocky sections.',
      ],
    ),
    TouristDestination(
      name: 'Casapsapan Beach',
      municipality: 'Casiguran',
      latitude: 16.2740,
      longitude: 122.0130,
      description: 'Quiet, less-crowded beach near Casiguran Sound.',
      activities: ['Swimming', 'Photography', 'Camping'],
      hours: 'Open 24/7',
      fees: 'Resort/parking fees may apply',
      tips: [
        'Bring cash; limited ATMs nearby.',
        'Pack out all trash; leave no trace.',
      ],
    ),
  ];

  // Tourist activities with associated risk levels
  static final List<TouristActivity> activities = [
    TouristActivity(
      name: 'Surfing (Baler)',
      icon: Icons.surfing,
      color: Colors.blue,
      locations: [
        'Sabang Beach - Baler',
        'Cemento Reef - Baler',
        "Charlie's Point - Baler"
      ],
      riskLevel: 'High',
      alerts: [
        'Check swell, wind, and typhoon advisories before paddling out.',
        'Beware of rip currents; if caught, swim parallel to shore to escape.',
        'Wear leash and reef-safe footwear; sharp rocks/urchins present at Cemento.',
        'Beginners should surf within designated zones at Sabang with instructors.',
      ],
      activeAlerts: [],
    ),
    TouristActivity(
      name: 'Waterfall Trekking & Swimming (San Luis)',
      icon: Icons.water,
      color: Colors.lightBlue,
      locations: [
        'Ditumabo (Mother) Falls - San Luis',
        'Caunayan Falls - San Luis'
      ],
      riskLevel: 'High',
      alerts: [
        'Trails may close during heavy rain; follow LGU advisories.',
        'Expect river crossings; wear closed-toe hiking shoes for grip.',
        'Keep distance from plunge pool; sudden water surges can occur.',
        'Hire accredited guides and follow checkpoint instructions.',
      ],
      activeAlerts: [],
    ),
    TouristActivity(
      name: 'Island Hopping & Tide Pools (Baler)',
      icon: Icons.waves,
      color: Colors.cyan,
      locations: [
        'Digisit Beach & Rock Formations - Baler',
        'Aniao Islets - Baler'
      ],
      riskLevel: 'Medium',
      alerts: [
        'Check tide schedule; tide pools are safest during low tide.',
        'Wear aqua shoes; sharp corals and rocks are common.',
        'Avoid climbing slippery rock formations; strong waves can sweep you.',
        'Boat rides only with accredited boatmen; always wear life vests.',
      ],
      activeAlerts: [],
    ),
    TouristActivity(
      name: 'Viewpoint Hiking & Lighthouse Ridge (Dingalan)',
      icon: Icons.terrain,
      color: Colors.green,
      locations: [
        'White Beach jump-off - Dingalan',
        'Dingalan Lighthouse & Viewdeck'
      ],
      riskLevel: 'Medium',
      alerts: [
        'Register at barangay/LGU; guide recommended for first-timers.',
        'If boating to White Beach, check sea state with the Coast Guard.',
        'Beware of strong winds at ridges; stay away from cliff edges.',
        'Avoid hiking during thunderstorms or after heavy rain (landslide risk).',
      ],
      activeAlerts: [],
    ),
    TouristActivity(
      name: 'Sea Caving (Lamao Caves, Dingalan)',
      icon: Icons.explore,
      color: Colors.deepPurple,
      locations: ['Lamao Caves - Dingalan'],
      riskLevel: 'Medium',
      alerts: [
        'Go with accredited guides; bring helmet and headlamp.',
        'Time your visit with the tide — some chambers flood at high tide.',
        'Beware of falling rocks and surge; never enter during big swells.',
        'Wear proper footwear; rocks are sharp and slippery.',
      ],
      activeAlerts: [],
    ),
    TouristActivity(
      name: 'Beach Swimming & Snorkeling',
      icon: Icons.beach_access,
      color: Colors.teal,
      locations: [
        'Dinadiawan Beach - Dipaculao',
        'Casapsapan Beach - Casiguran'
      ],
      riskLevel: 'Medium',
      alerts: [
        'Few areas have lifeguards; stay within waist-deep if unfamiliar.',
        'Watch for rip currents; avoid river mouths and rocky headlands.',
        'Possible jellyfish during hot months — use vinegar for stings.',
        'Use reef-safe sunscreen; do not step on or touch corals.',
      ],
      activeAlerts: [],
    ),
    TouristActivity(
      name: 'Giant Balete Tree & Nature Parks',
      icon: Icons.park,
      color: Colors.brown,
      locations: [
        'Millennium (Balete) Tree - Maria Aurora',
        'Aurora Memorial National Park'
      ],
      riskLevel: 'Low',
      alerts: [
        'Watch footing around exposed roots; surfaces can be slippery.',
        'Use insect protection and stay on marked paths.',
        'Respect site rules; no carving, picking, or littering.',
        'Keep noise low to protect wildlife and other visitors\' experience.',
      ],
      activeAlerts: [],
    ),
    TouristActivity(
      name: 'Heritage Walk (Baler Town)',
      icon: Icons.museum,
      color: Colors.orange,
      locations: [
        'Museo de Baler',
        'Ermita Hill',
        'Baler Church (San Luis Obispo de Tolosa)'
      ],
      riskLevel: 'Low',
      alerts: [
        'Hydrate and wear sun protection; mid-day heat can be extreme.',
        'Secure valuables; expect crowds on weekends and holidays.',
        'Follow heritage-site rules; avoid touching artifacts or displays.',
        'Check opening hours and weather-related closures.',
      ],
      activeAlerts: [],
    ),
    TouristActivity(
      name: 'Boating/Kayaking (Aurora Bays)',
      icon: Icons.directions_boat,
      color: Colors.cyan,
      locations: ['Baler Bay', 'Dingalan Bay', 'Casiguran Sound'],
      riskLevel: 'High',
      alerts: [
        'Life vests required at all times; follow boat crew instructions.',
        'Check weather bulletins and tide/wave forecasts before departure.',
        'Stay within safety markers; beware of rip and cross-currents.',
        'Coordinate with the Coast Guard for permits/clearance when needed.',
      ],
      activeAlerts: [],
    ),
  ];

  /// Check for nearby destinations and active alerts
  static Future<List<ActiveAlert>> checkForAlerts(Position position) async {
    List<ActiveAlert> nearbyAlerts = [];

    try {
      // Check each destination for proximity
      for (var destination in destinations) {
        // Define radius based on destination type (in kilometers)
        double radius = _getRadiusForDestination(destination);

        // Check if user is within radius of this destination
        if (LocationUtils.isWithinRadius(
            position.latitude,
            position.longitude,
            destination.latitude,
            destination.longitude,
            radius)) {
          // Find activities associated with this destination
          for (var activity in activities) {
            // Check if this destination is in the activity's locations
            if (activity.locations
                .any((loc) => loc.contains(destination.name))) {
              // Add all active alerts for this activity
              // Note: In the new implementation, we're replacing static alerts with weather-based alerts
            }
          }
        }
      }
      
      // Check for weather-based alerts
      List<ActiveAlert> weatherAlerts = await WeatherService.checkWeatherAlerts(position, activities);
      nearbyAlerts.addAll(weatherAlerts);
    } catch (e) {
      // Log error in a production environment
      // For now, we'll just return an empty list
      print('Error checking for alerts: $e');
      return nearbyAlerts;
    }

    return nearbyAlerts;
  }

  /// Get appropriate radius based on destination type
  static double _getRadiusForDestination(TouristDestination destination) {
    // Default radius
    double radius = 0.5; // 500 meters

    // Beaches get a larger radius
    if (destination.activities.contains('Beach') ||
        destination.activities.contains('Swimming') ||
        destination.activities.contains('Surfing')) {
      radius = 2.0; // 2 kilometers
    }
    // Hiking trails and mountains get medium radius
    else if (destination.activities.contains('Hiking') ||
        destination.activities.contains('Trekking') ||
        destination.activities.contains('Mountain')) {
      radius = 1.0; // 1 kilometer
    }

    return radius;
  }

  /// Show alert dialog with vibration feedback
  static void showAlert(BuildContext context, ActiveAlert alert) async {
    try {
      // Trigger vibration based on severity
      _triggerVibration(alert.severity);

      // Show alert dialog
      // Check if the context is still valid
      try {
        // Using a more compatible way to check if context is still valid
        if (context.findRenderObject() != null) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Row(
                  children: [
                    _getIconForAlertType(alert.type),
                    const SizedBox(width: 10),
                    Text(
                      alert.type,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _getColorForSeverity(alert.severity).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _getColorForSeverity(alert.severity),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.warning,
                            color: _getColorForSeverity(alert.severity),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${alert.severity} Risk',
                            style: TextStyle(
                              color: _getColorForSeverity(alert.severity),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      alert.message,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      alert.time,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Dismiss'),
                  ),
                ],
              );
            },
          );
        }
      } catch (dialogError) {
        // Silently handle dialog errors
      }
    } catch (e) {
      // Silently handle errors to avoid interrupting the alert system
    }
  }

  /// Trigger vibration based on alert severity
  static void _triggerVibration(String severity) async {
    try {
      // Check if vibration is available
      if (await Vibration.hasVibrator() != true) return;

      // Check if custom vibrations are available
      bool hasCustomVibration = await Vibration.hasCustomVibrationsSupport() == true;

      switch (severity.toLowerCase()) {
        case 'high':
          if (hasCustomVibration) {
            // Long vibration (1000ms) followed by short pause (500ms) repeated 3 times
            Vibration.vibrate(
              pattern: [0, 1000, 500, 1000, 500, 1000],
              intensities: [255, 255, 0, 255, 0, 255],
            );
          } else {
            Vibration.vibrate();
          }
          break;
        case 'medium':
          if (hasCustomVibration) {
            // Medium vibration (500ms) followed by short pause (500ms) repeated 2 times
            Vibration.vibrate(
              pattern: [0, 500, 500, 500],
              intensities: [128, 128, 0, 128],
            );
          } else {
            Vibration.vibrate();
          }
          break;
        case 'low':
          if (hasCustomVibration) {
            // Short vibration (250ms) once
            Vibration.vibrate(duration: 250, amplitude: 64);
          } else {
            Vibration.vibrate();
          }
          break;
        default:
          Vibration.vibrate();
      }
    } catch (e) {
      // Silently handle vibration errors to avoid interrupting the alert
      // Vibration is not critical to the alert functionality
    }
  }

  /// Get appropriate icon for alert type
  static Icon _getIconForAlertType(String type) {
    switch (type.toLowerCase()) {
      case 'weather':
        return const Icon(Icons.cloud, color: Colors.blue);
      case 'trail':
        return const Icon(Icons.directions_walk, color: Colors.green);
      case 'safety':
        return const Icon(Icons.security, color: Colors.red);
      case 'tide':
        return const Icon(Icons.waves, color: Colors.cyan);
      default:
        return const Icon(Icons.warning, color: Colors.orange);
    }
  }

  /// Get appropriate color for severity level
  static Color _getColorForSeverity(String severity) {
    switch (severity.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }
}