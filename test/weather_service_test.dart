import 'package:flutter_test/flutter_test.dart';
import 'package:autour_mobile/utils/weather_service.dart';
import 'package:autour_mobile/utils/alert_models.dart';

void main() {
  group('Weather Service Tests', () {
    test('String extension capitalize', () {
      expect('hello'.capitalize(), 'Hello');
      expect('WORLD'.capitalize(), 'WORLD');
      expect(''.capitalize(), '');
    });

    test('TouristActivity creation', () {
      TouristActivity activity = TouristActivity(
        name: 'Test Activity',
        icon: Icons.surfing,
        color: Colors.blue,
        locations: ['Test Location'],
        riskLevel: 'High',
        alerts: ['Test Alert'],
        activeAlerts: [],
      );
      
      expect(activity.name, 'Test Activity');
      expect(activity.riskLevel, 'High');
      expect(activity.locations.length, 1);
    });

    test('ActiveAlert creation', () {
      ActiveAlert alert = ActiveAlert(
        type: 'Weather',
        message: 'Test message',
        severity: 'High',
        time: 'Just now',
      );
      
      expect(alert.type, 'Weather');
      expect(alert.severity, 'High');
      expect(alert.message, 'Test message');
    });
  });
}