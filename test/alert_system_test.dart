import 'package:flutter_test/flutter_test.dart';
import 'package:autour_mobile/utils/alert_models.dart';
import 'package:autour_mobile/utils/location_utils.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  group('Location Utils Tests', () {
    test('Calculate distance between two points', () {
      // Test with known values
      double distance = LocationUtils.calculateDistance(
        15.7580, // Sabang Beach latitude
        121.5660, // Sabang Beach longitude
        15.6930, // Ditumabo Falls latitude
        121.5150, // Ditumabo Falls longitude
      );
      
      // The distance should be a positive value
      expect(distance, greaterThan(0));
    });

    test('Check if point is within radius', () {
      // Test with a very small radius (should be false)
      bool withinRadius = LocationUtils.isWithinRadius(
        15.7580, // Sabang Beach latitude
        121.5660, // Sabang Beach longitude
        15.6930, // Ditumabo Falls latitude
        121.5150, // Ditumabo Falls longitude
        0.001, // 1 meter radius
      );
      
      expect(withinRadius, false);
      
      // Test with a large radius (should be true)
      withinRadius = LocationUtils.isWithinRadius(
        15.7580, // Sabang Beach latitude
        121.5660, // Sabang Beach longitude
        15.6930, // Ditumabo Falls latitude
        121.5150, // Ditumabo Falls longitude
        100, // 100 km radius
      );
      
      expect(withinRadius, true);
    });
  });

  group('Alert Models Tests', () {
    test('Create TouristDestination from JSON', () {
      Map<String, dynamic> json = {
        'name': 'Test Beach',
        'municipality': 'Baler',
        'lat': 15.7580,
        'lng': 121.5660,
        'description': 'A test beach',
        'activities': ['Swimming', 'Surfing'],
        'hours': 'Open 24/7',
        'fees': 'Free',
        'tips': ['Wear sunscreen', 'Stay hydrated'],
      };
      
      TouristDestination destination = TouristDestination.fromJson(json);
      
      expect(destination.name, 'Test Beach');
      expect(destination.municipality, 'Baler');
      expect(destination.latitude, 15.7580);
      expect(destination.longitude, 121.5660);
      expect(destination.activities.length, 2);
      expect(destination.tips.length, 2);
    });

    test('Create ActiveAlert from Map', () {
      Map<String, dynamic> map = {
        'type': 'Weather',
        'message': 'Strong winds expected',
        'severity': 'High',
        'time': '2 hours ago',
      };
      
      ActiveAlert alert = ActiveAlert.fromMap(map);
      
      expect(alert.type, 'Weather');
      expect(alert.message, 'Strong winds expected');
      expect(alert.severity, 'High');
      expect(alert.time, '2 hours ago');
    });
  });
}